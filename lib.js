// Generated by CoffeeScript 1.3.3
(function() {
  var crypto, _;

  crypto = require('crypto');

  _ = exports || this;

  _.left_pad = function(s, n, c) {
    if (c == null) {
      c = '0';
    }
    return (new Array(n + 1).join(c) + s).substr(-Math.max(n, s.toString().length));
  };

  _.random_digits = function() {
    return ("00000000" + parseInt(crypto.randomBytes(4).toString('hex'), 16)).slice(-8);
  };

}).call(this);