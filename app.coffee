
###
Module dependencies.
###
express = require("express")
routes = require("./routes")
user = require("./routes/user")
http = require("http")
path = require("path")


jumpstarter = require "jumpstarter"


jumpstarter.createWorkers (done) ->
  app = express()

  app.configure ->
    app.set "port", process.env.PORT or 3000
    app.set "views", __dirname + "/views"
    app.set "view engine", "jade"
    app.use express.favicon()
    app.use express.logger("dev")
    app.use express.bodyParser()
    app.use express.methodOverride()
    app.use app.router
    app.use require("stylus").middleware(__dirname + "/public")
    app.use express.static(path.join(__dirname, "public"))

  app.configure "development", ->
    app.use express.errorHandler()

  app.get "/", routes.index
  app.get "/users", user.list

  http.createServer(app).listen app.get("port"), ->
    done({ port: app.get("port"), mode: app.settings.env });