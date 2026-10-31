# inspect

Readable nested-table output for debugging.

```sh
lpm install inspect
```

```lua
local inspect = require("inspect")
print(inspect({ status = "ready", items = {1, 2} }))
```

Upstream: https://github.com/kikito/inspect.lua

Revision: `a8ca3120dfec48801036eaeff9335ab7a096dd24`. LPM package version: `3.1.0`. Snapshot packages use an LPM packaging version, not an invented upstream release.

Uses its pure Lua fallback without optional LuaJIT or compat53 modules.

See LICENSE.txt for upstream terms. Source files are included in this repository; installation does not run an external installer.
