local memoize = require("memoize")
local square = memoize(function(x) return x * x end)
print(square(7))
