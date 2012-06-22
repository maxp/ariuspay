#
#   ariuspay: manager
#

mdb = require './mdb'

_x = exports or this


_x.paylist = (req, res) ->
  res.render "manager/list", pay_new: ''

_x.pay_new = (req, res) ->

  pm = new mdb.Payment {name: 'Vasya', email: 'a@bcd.ef', descr: 'give me all', amount: 100}
  pm.save (err) ->
    console.log 'save err:', err if err?


  console.log 'pm', pm

  res.render "manager/new"

#.
