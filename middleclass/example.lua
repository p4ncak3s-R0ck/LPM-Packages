local class = require("middleclass")
local Counter = class("Counter")
function Counter:initialize() self.value = 0 end
print(Counter():isInstanceOf(Counter))
