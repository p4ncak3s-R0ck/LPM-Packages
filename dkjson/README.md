# dkjson

JSON with explicit null preservation and formatted output.

```sh
lpm install dkjson
```

```lua
local json = require("dkjson")
local value = json.decode("[null,1]", 1, json.null)
print(value[1] == json.null)
print(json.encode(value, {indent = true}))
```

Upstream: https://dkolf.de/dkjson-lua/

Revision: `sha256:197cb50834c642f84b4cf99fe724932c50e6d9c92faec7ad89aa25e91df4d481`. LPM package version: `2.11.0`. Snapshot packages use an LPM packaging version, not an invented upstream release.

https://dkolf.de/dkjson-lua/
Source: official dkjson 2.11 release. Uses the pure Lua parser with no LPeg dependency. Pass json.null explicitly to decode to preserve null.

See LICENSE.txt for upstream terms. Source files are included in this repository; installation does not run an external installer.
