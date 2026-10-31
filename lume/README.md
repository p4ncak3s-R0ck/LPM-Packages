# lume

Table, string, collection and math utilities.

```sh
lpm install lume
```

```lua
local lume = require("lume")
print(lume.clamp(12, 0, 10))
```

Upstream: https://github.com/rxi/lume

Revision: `98847e7812cf28d3d64b289b03fad71dc704547d`. LPM package version: `2.3.0`. Snapshot packages use an LPM packaging version, not an invented upstream release.



See LICENSE.txt for upstream terms. Source files are included in this repository; installation does not run an external installer.

LPM adaptation: trace() works without debug.getinfo and prints ?:0 when caller information is unavailable.
