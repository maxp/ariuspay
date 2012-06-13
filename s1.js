// Generated by CoffeeScript 1.3.3
(function() {
  var SimpleMath, add, square, subtract;

  add = function(a, b) {
    return a + b;
  };

  subtract = function(a, b) {
    return a - b;
  };

  square = function(x) {
    return x * x;
  };

  SimpleMath = (typeof exports !== "undefined" && exports !== null) && exports || (this.SimpleMath = {});

  SimpleMath.Calculator = (function() {

    function Calculator() {}

    Calculator.prototype.add = add;

    Calculator.prototype.subtract = subtract;

    Calculator.prototype.square = square;

    return Calculator;

  })();

}).call(this);
