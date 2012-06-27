#
#   utility functions
#

crypto = require 'crypto'

_ = exports or this

# (pad+n).slice(-pad.length);

_.left_pad = (s, n, c='0') ->
  (new Array(n+1).join(c) + s).substr(-Math.max(n,s.toString().length))
#-

# 8 random digits
_.random_digits = -> ("00000000"+parseInt(crypto.randomBytes(4).toString('hex'), 16)).slice(-8)

#.
