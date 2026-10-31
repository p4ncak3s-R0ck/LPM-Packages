local cbor = require("cbor")
print(cbor.decode(cbor.encode({answer = 42})).answer)
