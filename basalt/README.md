# basalt

Full graphical application framework for CC:Tweaked.

```sh
lpm install basalt
```

```lua
local basalt = require("basalt")
local frame = basalt.createFrame()
frame:addLabel():setText("LPM + Basalt"):setPosition(2, 2)
basalt.autoUpdate()
```

Upstream: https://github.com/Pyroxenium/Basalt

Revision: `14c0630c1e110c5b507534e19e6c9607ba10df3e`. LPM package version: `1.7.1`. Snapshot packages use an LPM packaging version, not an invented upstream release.

Uses the upstream self-contained Basalt 1.7.1 release bundle, not an installer or the separate Basalt 2 API. Requires an advanced color computer; autoUpdate runs the event loop.

See LICENSE.txt for upstream terms. Source files are included in this repository; installation does not run an external installer.
