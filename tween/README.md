# tween

Interpolation and easing of numerical properties.

```sh
lpm install tween
```

```lua
local tween = require("tween")
local value = {x = 0}
local animation = tween.new(1, value, {x = 10}, "linear")
animation:update(0.5)
print(value.x)
```

Upstream: https://github.com/kikito/tween.lua

Revision: `9cdcd39339ec9e8b9c1a08e65aa0a8f2aab62172`. LPM package version: `2.1.1`. Snapshot packages use an LPM packaging version, not an invented upstream release.

Call update with elapsed real seconds from your event loop; no background task is started.

See LICENSE.txt for upstream terms. Source files are included in this repository; installation does not run an external installer.
