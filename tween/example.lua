local tween = require("tween")
local value = {x = 0}
local animation = tween.new(1, value, {x = 10}, "linear")
animation:update(0.5)
print(value.x)
