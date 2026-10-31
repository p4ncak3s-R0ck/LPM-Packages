# stateful

State-dependent behavior for Middleclass objects.

```sh
lpm install stateful
```

```lua
local class = require("middleclass")
local Stateful = require("stateful")
local Device = class("Device"):include(Stateful)
Device:addState("Ready")
local device = Device()
device:gotoState("Ready")
print(device:getStateStackDebugInfo())
```

Upstream: https://github.com/kikito/stateful.lua

Revision: `bf0da2b5a9201a9a31223a1b5b0d0bef2817c71c`. LPM package version: `1.0.5`. Snapshot packages use an LPM packaging version, not an invented upstream release.

Depends on Middleclass.

See LICENSE.txt for upstream terms. Source files are included in this repository; installation does not run an external installer.
