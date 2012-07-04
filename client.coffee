#
#   ariuspay: client
#

_ = exports or this

crypto = require 'crypto'
config = require 'config'
#https  = require 'https'
request = require 'request'
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
#      r_opt = url.parse arius_url
#      r_opt.method = 'POST'

      sha = crypto.createHash 'sha1'
      sha.update ep + ord.order_id + (ord.amount * 100) + ord.email
      sha.update config.arius.merc_key

      data =
        client_orderid: ord.order_id
        email: ord.email
        amount: ""+ord.amount+".00"
        currency: "RUR"
        order_desc: ord.descr
        control: sha.digest 'hex'
        redirect_url: 'http://ya.ru'
        ipaddress: req.connection.remoteAddress   # check for x-real-ip
        country: "RU"
        city: "Irkutsk"
        zip_code: "664000"
        address1: "Rio de Bodaibo"
        # server_callback_url: "..."

      console.log 'data:', data

      ar = request.post {url: arius_url, form: data}, (err, rsp, body) ->
#          console.log 'err:', err
#          console.log 'res:', rsp
          console.log 'body:', body

          res.send err: 999

    else
      res.send err: 2
#.
