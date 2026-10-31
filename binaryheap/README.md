# binaryheap

Binary heaps and priority queues.

```sh
lpm install binaryheap
```

```lua
local binaryheap = require("binaryheap")
local heap = binaryheap.minHeap()
heap:insert(20)
heap:insert(5)
print(heap:pop())
```

Upstream: https://github.com/Tieske/binaryheap.lua

Revision: `5527c544c01d63497ed5cdfe209436a4a72bad0f`. LPM package version: `0.4.0`. Snapshot packages use an LPM packaging version, not an invented upstream release.



See LICENSE.txt for upstream terms. Source files are included in this repository; installation does not run an external installer.
