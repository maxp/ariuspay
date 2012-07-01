#
#   ariuspay: client
#

_ = exports or this

mdb = require './mdb'
crypto = require 'crypto'

_.bill = (req, res) ->

  [id, srand] = req.params.id_srand.split '-', 2

#  mdb.Payments.

  # load it
  bill = id: id, srand: srand

  console.log bill

  shasum = crypto.createHash 'sha1'
  shasum.update "foo"

  console.log shasum.digest 'hex'

  # hash1 = crypto.createHash('sha1').update('Test123').digest('hex');

  res.render 'client/bill', {bill: bill}
#-

#.
