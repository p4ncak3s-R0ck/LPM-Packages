# lust

Unit tests, assertions and spies.

```sh
lpm install lust
```

```lua
local lust = require("lust").nocolor()
lust.describe("arithmetic", function()
    lust.it("adds", function() lust.expect(2 + 2).to.equal(4) end)
end)
assert(lust.errors == 0)
```

Upstream: https://github.com/bjornbytes/lust

Revision: `80acb4f748621ed3668548770a1df744d4e55d1d`. LPM package version: `0.2.0`. Snapshot packages use an LPM packaging version, not an invented upstream release.

Use nocolor() because CraftOS does not interpret ANSI color escapes.

See LICENSE.txt for upstream terms. Source files are included in this repository; installation does not run an external installer.
