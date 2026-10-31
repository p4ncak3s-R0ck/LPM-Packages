# ccryptolib

Cryptographic primitives required by ECNet2.

```sh
lpm install ccryptolib
```

```lua
local sha256 = require("ccryptolib.sha256")
print(#sha256.digest("abc"))
```

Upstream: https://github.com/migeyel/ccryptolib

Revision: `14489aa1ec408f8a07e1292be5ef91dfe8567c74`. LPM package version: `1.2.0`. Snapshot packages use an LPM packaging version, not an invented upstream release.

Dependency package for ECNet2. Initialize ccryptolib.random with a trusted entropy source before using secret-key operations. Installation never initializes random state or contacts external entropy services. See upstream README for init and initWithTiming tradeoffs.

See LICENSE.txt for upstream terms. Source files are included in this repository; installation does not run an external installer.
