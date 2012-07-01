// Generated by CoffeeScript 1.3.3
(function() {
  var crypto, mdb, _;

  _ = exports || this;

  mdb = require('./mdb');

  crypto = require('crypto');

  _.bill = function(req, res) {
    var bill, id, shasum, srand, _ref;
    _ref = req.params.id_srand.split('-', 2), id = _ref[0], srand = _ref[1];
    bill = {
      id: id,
      srand: srand
    };
    console.log(bill);
    shasum = crypto.createHash('sha1');
    shasum.update("foo");
    console.log(shasum.digest('hex'));
    return res.render('client/bill', {
      bill: bill
    });
  };

}).call(this);
