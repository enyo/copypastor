
# Module dependencies.
cluster = require("cluster")
numCPUs = require('os').cpus().length


# Counts the number of restarts
restarts = 0
workers = 0
delay = 5

exports.createWorkers = (startupFunction) ->

  console.log "Starting only one worker because not in production mode." if process.env.NODE_ENV != "production"

  if cluster.isMaster and process.env.NODE_ENV == "production"
    console.log "Starting node cluster with #{numCPUs} workers."

    workersId = "#{new Date().getTime()}-#{process.pid}"

    # Fork workers.
    for i in [0...numCPUs]
      cluster.fork()

    cluster.on "exit", (worker, code, signal) ->
      console.error "Worker #{worker.process.pid} died (Code: #{code})."
      unless signal?
        console.log "Restarting in #{delay} seconds (restarted #{restarts} already)..."
        restarts++
        setTimeout (-> cluster.fork()), delay * 1000
        

  else

    startupFunction (info) ->
      log = "Worker #{process.pid} created."
      if info?.port and info.mode
        log += " Express server listening on port #{info.port} in #{info.mode} mode"
      console.log log
