// Generated by CoffeeScript 1.3.3
(function() {
  var mdb, _x;

  mdb = require('./mdb');

  _x = exports || this;

  _x.paylist = function(req, res) {
    return res.render("manager/list", {
      pay_new: ''
    });
  };

  _x.newpay = function(req, res) {
    var pm;
    pm = new mdb.Payment({
      name: 'Vasya',
      email: 'a@bcd.ef',
      descr: 'give me all',
      amount: 100
    });
    pm.save(function(err) {
      if (err != null) {
        return console.log('save err:', err);
      }
    });
    return res.render("manager/newpay");
  };

  _x.newpay_post = function(req, res) {
    return res.send({
      ok: 1
    });
  };

}).call(this);
