local machine = require("statemachine")
local device = machine.create({initial = "off", events = {{name = "start", from = "off", to = "on"}}})
device:start()
print(device.current)
