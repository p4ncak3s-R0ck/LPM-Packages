# deque

Efficient double-ended queues.

```sh
lpm install deque
```

```lua
local Deque = require("deque")
local queue = Deque:new()
queue:append("first")
queue:unshift("urgent")
print(queue:shift())
```

Upstream: https://github.com/MCJack123/LuaDS

Revision: `31f1d5cb1669c71b2e59f304438a47db4f6d4cd0`. LPM package version: `0.1.0`. Snapshot packages use an LPM packaging version, not an invented upstream release.

Upstream LuaDS Deque snapshot. The internal expect import is adapted to the built-in cc.expect module.

See LICENSE.txt for upstream terms. Source files are included in this repository; installation does not run an external installer.
