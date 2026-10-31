# cron

Update-driven delayed and repeating callbacks.

```sh
lpm install cron
```

```lua
local cron = require("cron")
local timer = cron.after(1, function() print("done") end)
timer:update(1)
```

Upstream: https://github.com/kikito/cron.lua

Revision: `bedcb48355ce99a9df37090c9304de356cf73b42`. LPM package version: `2.0.0`. Snapshot packages use an LPM packaging version, not an invented upstream release.

This is not OS cron. Advance timers explicitly with elapsed real seconds.

See LICENSE.txt for upstream terms. Source files are included in this repository; installation does not run an external installer.

LPM adaptation: uses table.unpack on modern CraftOS instead of assuming Lua 5.1 global unpack.
