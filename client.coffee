#
#   ariuspay: client
#

_ = exports or this

crypto = require 'crypto'
config = require 'config'
https  = require 'https'
url    = require 'url'

mdb    = require './mdb'


_.bill = (req, res) ->
  #
  [order_id, srand] = req.params.order_srand.split '-', 2
  mdb.Orders.findOne {order_id: order_id, srand: srand}, (err, ord) ->
    if ord
      res.render 'client/bill', order: ord
    else
      res.send "not found"
#-

_.bill_redir = (req, res) ->

  console.log 'bill_redir'
  #
  [order_id, srand] = req.params.order_srand.split '-', 2
  mdb.Orders.findOne {order_id: order_id, srand: srand}, (err, ord) ->
    if ord
      ep = config.arius.endpoint
      arius_url = config.arius.api_url+"sale-form/"+ep
      r_opt = url.parse arius_url
      r_opt.method = 'POST'

      sha = crypto.createHash 'sha1'
      sha.update ep + ord.order_id + (ord.amount * 100) + ord.email
      sha.update config.arius.merc_key

      data =
        order: ord

        control: sha.digest 'hex'
        redirect_url: 'http://ya.ru'
        ip_addr: req.connection.remoteAddress   # check for x-real-ip
        # server_callback_url: "..."

      console.log 'bill_data:', data

      ar = https.request( r_opt, (h) ->

        console.log 'arius: ', h
        console.log "statusCode: ", h.statusCode
        console.log "headers: ", h.headers

        buffer = ""
        h.on 'data', (d) ->
          console.log 'on_data'
          buffer += d
        #
        h.on 'end', ->
          console.log 'arius end: ', buffer
          # decode buffer
#          redir = "arius url"
#          res.send {ok: 1, redir: redir}
          res.send err: 999
        #
        h.on 'error', (e) ->
          console.log 'arius_err:', e
          res.send err: 4
        #
      ).on('error', (e) ->
        console.log 'ar_error:', e
        res.send err: 3
      ).end()

    else
      res.send err: 2
#.
