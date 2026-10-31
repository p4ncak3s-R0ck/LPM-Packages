# moses

Functional collection operations and chaining.

```sh
lpm install moses
```

```lua
local moses = require("moses")
local doubled = moses.map({1, 2, 3}, function(v) return v * 2 end)
print(table.concat(doubled, ","))
```

Upstream: https://github.com/Yonaba/Moses

Revision: `6fe8d76d50a22d85fe064aaa80390b72381befed`. LPM package version: `2.1.0`. Snapshot packages use an LPM packaging version, not an invented upstream release.



See LICENSE.txt for upstream terms. Source files are included in this repository; installation does not run an external installer.
