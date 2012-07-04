#
#   ariuspay: manager
#

util = require 'util'
du   = require 'date-utils'
lib  = require './lib'

config = require 'config'

mdb  = require './mdb'


_x = exports or this

_x.paylist = (req, res) ->

  mdb.Orders.find({}).sort('ts', -1).limit(50).exec (err, orders) ->
    res.render "manager/list", {
      orders: orders,
      bill_href: (p) ->
        if p.state in ['new','sent']
          config.server.baseurl+"bill/"+p.order_id+"-"+p.srand
    }
#-

_x.new_order = (req, res) ->
  res.render "manager/new_order"
#-

_x.new_order_post = (req, res) ->

  b = req.body
  amount = parseInt(b.amount)

  # TODO: validate input
  if amount > 0
    mdb.inc_counter "order_id", 1, (err, seq) ->

      order_id = new Date().toFormat("YYMMDD") + lib.left_pad(seq, 6)

      order = new mdb.Orders {
        order_id: order_id,
        srand: lib.random_digits(),
        name: b.name,
        email: b.email,
        descr: b.descr,
        amount: amount
      }

      order.save (err) ->
        console.log 'save err:', err if err?

      res.send redir: config.server.baseurl+"manager/"  # list
    #-
  else
    res.send err: 1
  #
#-

_x.send_link = (req, res) ->

  # TODO: send email to the client

  res.send {ok:1}
#-

#.
