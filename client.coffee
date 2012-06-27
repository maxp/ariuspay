#
#   ariuspay: client
#

_ = exports or this


_.bill = (req, res) ->

  [id, srand] = req.params.id_srand.split '-'

  # load it
  bill = id: id, srand: srand

  console.log bill

  res.render 'client/bill', {bill: bill}
#-

#.
