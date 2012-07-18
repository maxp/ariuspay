#
#   ariuspay application
#

VERSION = "ariuspay 0.0.2"

console.log "#{VERSION} starting at: "+new Date

RUN_CONFS = ["development", "production"]

if not process.env.NODE_ENV
  process.env.NODE_ENV = 'development'

node_env = process.env.NODE_ENV

if node_env not in RUN_CONFS
  console.error "NODE_ENV[#{node_env}] not in ", RUN_CONFS
  process.exit 1
#-

config = require 'config'
express = require 'express'

#http = require "http"
#url  = require "url"
#qs   = require "querystring"

mdb = require './mdb'

app = express.createServer()
# key: ...

app.configure ->
  app.set "views", __dirname+"/views"
  app.set "view engine", 'jade'
  app.set "view options", {layout: false, pretty: false, cache: true}

  app.use express.favicon()   # "path_to/favicon.ico"

  app.use express.logger "dev"
  app.use express.bodyParser()

  # app.use(express.cookieParser(...));
  # app.use(express.session(...));
  # .use(connect.session({ key: 'sid', cookie: { secure: true }}))

  app.use app.router
  app.use '/inc', express.static __dirname+"/inc"
  # app.use '/inc', express.static __dirname+"/inc", {maxAge: 365*24*3600*1000}


app.configure "development", ->
  app.set "view options", {layout: false, pretty: true, cache: false}
  app.use express.errorHandler {dumpExceptions: true, showStack: true}

app.configure "production", ->
  app.use express.errorHandler()

manager = require './manager'
client  = require './client'

base_uri = config.server.base_uri

app.get  "/", (req, res) ->
  res.redirect base_uri+"manager/"

app.get  base_uri+"manager/", manager.paylist

app.get  base_uri+"manager/new_order", manager.new_order
app.post base_uri+"manager/new_order", manager.new_order_post
# TODO: edit order
# app.get  base_uri+"manager/order/:id", manager.order
# app.post base_uri+"manager/order/:id", manager.order_post


app.get  base_uri+"bill/:order_srand", client.bill
app.post base_uri+"bill/:order_srand", client.bill_redir

app.listen config.server.port

#.