#
#   ariuspay: mdb
#

_ = exports or this

mongoose = require 'mongoose'
Schema   = mongoose.Schema
oid      = Schema.ObjectId

config  = require 'config'

mongoose.connect config.datasource.url


Counter = new Schema {_id: String, val: Number}

Counter.statics.findAndModify = (query, sort, doc, options, callback) ->
  @.collection.findAndModify query, sort, doc, options, callback

Counters = mongoose.model 'counter', Counter

_.Counters = Counters

_.inc_counter = (name, n, cb) ->
  Counters.findAndModify {_id: name}, [], {$inc: {val: n}}, {'new':true, upsert:true}, (err, res) ->
    if err then cb(err) else cb(null, res.val)
#--

Payment = new Schema
  _id: oid
  state: { type: String, default: 'new', enum: ['new', 'sent', 'paid', 'canc', 'del'] }
  ts: { type: Date, default: Date.now }

  name: String
  email: String
  descr: String
  amount: Number

  merc_id: String     # merchant transaction id
  srand: String       # secure random key
  arius_id: String    # ariuspay transaction id
#--

_.Payments = mongoose.model 'payment', Payment

#.
