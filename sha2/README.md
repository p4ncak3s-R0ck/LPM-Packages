# sha2

Pure Lua SHA family hashes and HMAC.

```sh
lpm install sha2
```

```lua
local sha2 = require("sha2")
print(sha2.sha256("abc"))
```

Upstream: https://github.com/Egor-Skriptunoff/pure_lua_SHA

Revision: `6adac177c16c3496899f69d220dfb20bc31c03df`. LPM package version: `0.1.0`. Snapshot packages use an LPM packaging version, not an invented upstream release.

Upstream snapshot with LPM packaging version 0.1.0. Large inputs may need cooperative scheduling on real computers.

See LICENSE.txt for upstream terms. Source files are included in this repository; installation does not run an external installer.
