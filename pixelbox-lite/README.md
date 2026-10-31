# pixelbox-lite

Teletext pixel graphics for terminals and monitors.

```sh
lpm install pixelbox-lite
```

```lua
local pixelbox = require("pixelbox_lite")
local box = pixelbox.new(term.current(), colors.black)
box:set_pixel(1, 1, colors.red)
box:render()
```

Upstream: https://github.com/9551-Dev/pixelbox_lite

Revision: `82098c8dca939b7689f119d0a577c311d4a09281`. LPM package version: `0.1.0`. Snapshot packages use an LPM packaging version, not an invented upstream release.

Use require("pixelbox_lite"). Requires a color terminal or monitor.

See LICENSE.txt for upstream terms. Source files are included in this repository; installation does not run an external installer.
