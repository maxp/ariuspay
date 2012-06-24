#
#   ariuspay: manager
#

util = require 'util'
du   = require 'date-utils'
crypto = require 'crypto'

config = require 'config'

mdb  = require './mdb'

# (pad+n).slice(-pad.length);

left_pad = (s, n, c='0') ->
  (new Array(n+1).join(c) + s).substr(-Math.max(n,s.toString().length))
#-

_x = exports or this

_x.paylist = (req, res) ->

  mdb.Payments.find({}).sort('ts', -1).exec (err, pay_list) ->
    res.render "manager/list", {
      pay_list: pay_list
    }
#-

_x.newpay = (req, res) ->
  res.render "manager/newpay"
#-

_x.newpay_post = (req, res) ->

  console.log 'newpay_post:', req.body

  b = req.body
  amount = parseInt(b.amount)

  # TODO: validate input
  if amount > 0
    mdb.inc_counter "merc_id", 1, (err, seq) ->

      merc_id = new Date().toFormat("YYMMDD") + left_pad(seq, 6)

      console.log 'merc_id:', merc_id

      pm = new mdb.Payments {
        merc_id: merc_id,
        arius_id: "",
        srand: ("00000000"+parseInt(crypto.randomBytes(4).toString('hex'), 16)).slice(-8)
        name: b.name, email: b.email, descr: b.descr,
        amount: amount
      }

      pm.save (err) ->
        console.log 'save err:', err if err?

      res.send {ok: 1}
    #-
  else
    res.send {ok: 1}
  #
#-

_x.send_link = (req, res) ->

  # TODO: send email to the client

  res.send {ok:1}
#-

#.
