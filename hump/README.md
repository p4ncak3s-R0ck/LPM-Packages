# hump

Standalone timers, signals and two-dimensional vectors.

```sh
lpm install hump
```

```lua
local vector = require("hump.vector")
local timer = require("hump.timer").new()
local point = vector(3, 4)
print(point:len())
timer:after(1, function() print("done") end)
timer:update(1)
```

Upstream: https://github.com/vrld/hump

Revision: `08937cc0ecf72d1a964a8de6cd552c5e136bf0d4`. LPM package version: `0.4.0`. Snapshot packages use an LPM packaging version, not an invented upstream release.

Includes only timer, signal and vector. LÖVE-dependent camera, gamestate and other modules are deliberately excluded. Require the documented hump.* modules.

See LICENSE.txt for upstream terms. Source files are included in this repository; installation does not run an external installer.
