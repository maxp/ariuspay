#
#   ariuspay: mdb
#

_x = exports or this

mongoose = require 'mongoose'
Schema   = mongoose.Schema
oid      = Schema.ObjectId

config  = require 'config'

mongoose.connect config.datasource.url

PaymentSchema = new Schema
  _id: oid
  state: { type: String, default: 'new', enum: ['new', 'sent', 'paid', 'canc', 'del'] }
  ts: { type: Date, default: new Date }

  name: String
  email: String
  descr: String
  amount: Number

  merc_id: String     # merchant transaction id
  arius_id: String    # ariuspay transaction id
#--

_x.Payment = mongoose.model 'payment', PaymentSchema

#.
