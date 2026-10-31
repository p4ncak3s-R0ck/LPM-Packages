# memoize

Memoization of function results.

```sh
lpm install memoize
```

```lua
local memoize = require("memoize")
local square = memoize(function(x) return x * x end)
print(square(7))
```

Upstream: https://github.com/kikito/memoize.lua

Revision: `bd7a8b8694649f1388d7b0e09ebda62ae036843f`. LPM package version: `2.0.0`. Snapshot packages use an LPM packaging version, not an invented upstream release.

Use with pure functions; results for changing external state can become stale.

See LICENSE.txt for upstream terms. Source files are included in this repository; installation does not run an external installer.
