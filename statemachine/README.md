# statemachine

Finite state machines with transitions and callbacks.

```sh
lpm install statemachine
```

```lua
local machine = require("statemachine")
local device = machine.create({initial = "off", events = {{name = "start", from = "off", to = "on"}}})
device:start()
print(device.current)
```

Upstream: https://github.com/kyleconroy/lua-state-machine

Revision: `96fc10ee123479cf2e5fb8ffe9cdde2fd6df0877`. LPM package version: `1.0.0`. Snapshot packages use an LPM packaging version, not an invented upstream release.



See LICENSE.txt for upstream terms. Source files are included in this repository; installation does not run an external installer.
