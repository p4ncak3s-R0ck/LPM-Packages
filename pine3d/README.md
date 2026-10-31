# pine3d

3D rendering for CC:Tweaked terminals.

```sh
lpm install pine3d
```

```lua
local Pine3D = require("pine3d")
local frame = Pine3D.newFrame()
frame:drawObjects({})
frame:drawBuffer()
```

Upstream: https://github.com/Xella37/Pine3D

Revision: `2fbbd2cebe9b1ce8a8fc173a2a8a7694878a62a4`. LPM package version: `0.1.0`. Snapshot packages use an LPM packaging version, not an invented upstream release.

Upstream snapshot. Internal renderer is namespaced to avoid collisions. Model assets are optional and are not installed; see upstream for the model format.

See LICENSE.txt for upstream terms. Source files are included in this repository; installation does not run an external installer.
