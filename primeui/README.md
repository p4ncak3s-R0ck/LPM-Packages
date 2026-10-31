# primeui

Composable UI components for CC:Tweaked.

```sh
lpm install primeui
```

```lua
local ui = require("primeui")
ui.clear()
ui.label(term.current(), 2, 2, "LPM + PrimeUI")
```

Upstream: https://github.com/MCJack123/PrimeUI

Revision: `66f2d285897031a5ebdc60d3ab869a908dbff210`. LPM package version: `0.1.0`. Snapshot packages use an LPM packaging version, not an invented upstream release.

LPM namespaces all component imports under primeui.* to avoid exporting generic util/button modules. No upstream algorithms are changed.

See LICENSE.txt for upstream terms. Source files are included in this repository; installation does not run an external installer.
