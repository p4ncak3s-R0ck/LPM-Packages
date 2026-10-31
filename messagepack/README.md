# messagepack

Compact MessagePack serialization.

```sh
lpm install messagepack
```

```lua
local msgpack = require("MessagePack")
local value = msgpack.unpack(msgpack.pack({online = true, count = 3}))
print(value.count)
```

Upstream: https://fperrad.frama.io/lua-MessagePack/

Revision: `sha256:86e5aedc94342f1447b3cac26dfacc69f05b0827221cd5e44d3b623087b16f37`. LPM package version: `0.5.4`. Snapshot packages use an LPM packaging version, not an invented upstream release.

https://fperrad.frama.io/lua-MessagePack/
Source: LuaRocks lua-messagepack 0.5.4 source rock. LPM patch skips bytecode number-format inspection when string.dump is unavailable in CraftOS; uses the standard 8-byte Lua number fallback. Integers beyond exact IEEE-754 range can lose precision.

See LICENSE.txt for upstream terms. Source files are included in this repository; installation does not run an external installer.
