local pixelbox = require("pixelbox_lite")
local box = pixelbox.new(term.current(), colors.black)
box:set_pixel(1, 1, colors.red)
box:render()
