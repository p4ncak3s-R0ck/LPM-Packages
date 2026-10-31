# bump

Spatial indexing and axis-aligned collision detection.

```sh
lpm install bump
```

```lua
local bump = require("bump")
local world = bump.newWorld(16)
world:add("wall", 10, 0, 1, 20)
print(world:countItems())
```

Upstream: https://github.com/kikito/bump.lua

Revision: `95d9e40b8aee295fc9d9b78ca214a829d6c21555`. LPM package version: `3.1.7`. Snapshot packages use an LPM packaging version, not an invented upstream release.

Uses coordinates only; no LÖVE dependency.

See LICENSE.txt for upstream terms. Source files are included in this repository; installation does not run an external installer.
