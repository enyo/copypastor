
###
Module dependencies.
###
express = require "express"
routes = require "./routes"
http = require "http"
path = require "path"
config = require "config"
mongoose = require "mongoose"

RedisStore = require("connect-redis") express

mongoose.connect config.mongoose.connectPath

jumpstarter = require "jumpstarter"


jumpstarter.createWorkers (done) ->
  app = express()

  app.configure ->
    app.set "port", process.env.PORT or config.general.portOrSocket
    app.set "views", __dirname + "/views"
    app.set "view engine", "jade"
    app.use express.favicon()
    app.use express.logger("dev")
    app.use express.bodyParser()
    app.use express.methodOverride()
    app.use express.cookieParser config.general.cookieSecret

    app.locals.moment = require "moment"

    app.use express.session
      store: new RedisStore
        socket: config.redis.socket
        host: config.redis.host
      secret: config.session.secret

    app.use app.router
    app.use require("stylus").middleware(__dirname + "/public")
    app.use express.static(path.join(__dirname, "public"))

  app.configure "development", ->
    app.use express.errorHandler()



  # mongoRest = new (require("mongo-rest")) app
  # mongoRest.addResource require("./models/paste"), sort: "_id"

  app.get "/", routes.index
  app.post "/", routes.newTextBlock
  app.get "/list", routes.list
  app.get "/:id", routes.textBlock



  http.createServer(app).listen app.get("port"), ->
    done({ port: app.get("port"), mode: app.settings.env });