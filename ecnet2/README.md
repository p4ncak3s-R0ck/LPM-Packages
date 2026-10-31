# ecnet2

Encrypted modem connections for CC:Tweaked.

```sh
lpm install ecnet2
```

```lua
local ecnet2 = require("ecnet2")
print(ecnet2.ANONYMOUS.address)
```

Upstream: https://github.com/migeyel/ecnet

Revision: `15dcf3e6d396523f7273d67e00cc24e5bc52c8c8`. LPM package version: `0.1.0`. Snapshot packages use an LPM packaging version, not an invented upstream release.

Includes all protocol and identity modules. Initialize ccryptolib.random before creating secret identities or connections, open your modem, and run ecnet2.daemon alongside application code. No modem or HTTP activity is started by installation.

See LICENSE.txt for upstream terms. Source files are included in this repository; installation does not run an external installer.
