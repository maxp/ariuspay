
# simpleMath.coffee

# these methods are private
add = (a, b) ->
  a + b

subtract = (a, b) ->
  a - b

square = (x) ->
  x * x

# create a namespace to export our public methods
SimpleMath = exports? and exports or (@SimpleMath = {})

# items attached to our namespace are available in Node.js as well as client browsers
class SimpleMath.Calculator
  add: add
  subtract: subtract
  square: square
