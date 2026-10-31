local ini = require("inifile")
local config = ini.parse("[server]\nport=80\n", "memory")
print(config.server.port)
print(ini.save("", config, "memory"))
