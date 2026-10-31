# middleclass

Classes, inheritance and mixins.

```sh
lpm install middleclass
```

```lua
local class = require("middleclass")
local Counter = class("Counter")
function Counter:initialize() self.value = 0 end
print(Counter():isInstanceOf(Counter))
```

Upstream: https://github.com/kikito/middleclass

Revision: `359f0e2742f51ca77801b513ec91eb9029de8de4`. LPM package version: `4.1.1`. Snapshot packages use an LPM packaging version, not an invented upstream release.



See LICENSE.txt for upstream terms. Source files are included in this repository; installation does not run an external installer.
