local json = require("json")
print(json.decode(json.encode({online = true})).online)
