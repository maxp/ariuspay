// Generated by CoffeeScript 1.3.3
(function() {
  var _;

  _ = exports || this;

  _.bill = function(req, res) {
    var bill, id, srand, _ref;
    _ref = req.params.id_srand.split('-'), id = _ref[0], srand = _ref[1];
    bill = {
      id: id,
      srand: srand
    };
    console.log(bill);
    return res.render('client/bill', {
      bill: bill
    });
  };

}).call(this);
