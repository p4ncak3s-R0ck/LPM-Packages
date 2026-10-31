# cbor

CBOR binary serialization.

```sh
lpm install cbor
```

```lua
local cbor = require("cbor")
print(cbor.decode(cbor.encode({answer = 42})).answer)
```

Upstream: https://www.zash.se/lua-cbor.html

Revision: `sha256:3f964b37770dcbc0b2622cd194f9485b6f3327ea65234126e03ce992f8d6b1e8`. LPM package version: `1.0.0`. Snapshot packages use an LPM packaging version, not an invented upstream release.

https://www.zash.se/lua-cbor.html
Source: LuaRocks lua-cbor 1.0.0 source rock. LPM patch falls back to ordinary getmetatable when debug is unavailable. Uses pure Lua number/bit fallbacks; native big-number extensions are not included. IEEE-754 integer precision limits apply.

See LICENSE.txt for upstream terms. Source files are included in this repository; installation does not run an external installer.
