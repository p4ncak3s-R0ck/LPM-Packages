local bump = require("bump")
local world = bump.newWorld(16)
world:add("wall", 10, 0, 1, 20)
print(world:countItems())
