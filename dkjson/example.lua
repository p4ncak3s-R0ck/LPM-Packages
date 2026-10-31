local json = require("dkjson")
local value = json.decode("[null,1]", 1, json.null)
print(value[1] == json.null)
print(json.encode(value, {indent = true}))
