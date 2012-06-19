###
  ariuspay application
###

VER = "ariuspay 0.0.1"

console.log "#{VER} starting at: "+new Date

RUN_CONFS = ["development", "production"]

util = require 'util'

if not process.env.NODE_ENV
  process.env.NODE_ENV = 'development'
else
  if process.env.NODE_ENV not in RUN_CONFS
    console.error "NODE_ENV not in "+util.inspect RUN_CONFS
    process.exit 1
#-

config = require 'config'
express = require 'express'

db = config.datasource.db


http = require "http"
url  = require "url"
qs   = require "querystring"

app = express.createServer()
# key: ...

app.configure ->
  app.set "views", __dirname+"/views"
  app.set "view engine", 'jade'
  app.set "view options", {layout: false}

  app.use express.bodyParser()
  # app.use(express.cookieParser(...));
  # app.use(express.session(...));
  app.use app.router
  app.use express.static __dirname+"/inc"
  # app.use express.static __dirname+"/inc", {maxAge: 365*24*3600*1000}


app.configure "development", ->
  app.use express.errorHandler {dumpExceptions: true, showStack: true}

app.configure "production", ->
  app.use express.errorHandler()



app.get "/", (req, res) ->
  res.redirect "/payment/manager/"

app.get "/payment/manager/", (req, res) ->
  res.send "manager"

app.listen config.http.port

#.