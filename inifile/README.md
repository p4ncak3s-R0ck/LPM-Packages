# inifile

INI configuration file parsing and writing.

```sh
lpm install inifile
```

```lua
local ini = require("inifile")
local config = ini.parse("[server]\nport=80\n", "memory")
print(config.server.port)
print(ini.save("", config, "memory"))
```

Upstream: https://github.com/bartbes/inifile

Revision: `f283d4a842729c2a3f587e4c20e824519b36e495`. LPM package version: `1.1.0`. Snapshot packages use an LPM packaging version, not an invented upstream release.

Supports io-backed CraftOS files and the memory backend. LPM patch ensures the final memory line is parsed even without a trailing newline.

See LICENSE.txt for upstream terms. Source files are included in this repository; installation does not run an external installer.
