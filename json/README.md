# json

Lightweight JSON encoding and decoding.

```sh
lpm install json
```

```lua
local json = require("json")
print(json.decode(json.encode({online = true})).online)
```

Upstream: https://github.com/rxi/json.lua

Revision: `dbf4b2dd2eb7c23be2773c89eb059dadd6436f94`. LPM package version: `0.1.2`. Snapshot packages use an LPM packaging version, not an invented upstream release.

JSON null decodes to nil; use dkjson when you need to preserve null entries.

See LICENSE.txt for upstream terms. Source files are included in this repository; installation does not run an external installer.
