local msgpack = require("MessagePack")
local value = msgpack.unpack(msgpack.pack({online = true, count = 3}))
print(value.count)
