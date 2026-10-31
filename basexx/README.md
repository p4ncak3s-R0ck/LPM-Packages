# basexx

Base64, Base32, hex and other binary-text encodings.

```sh
lpm install basexx
```

```lua
local basexx = require("basexx")
print(basexx.from_base64(basexx.to_base64("hello")))
```

Upstream: https://github.com/aiq/basexx

Revision: `b4ee13f6503499dc52c2d349a81826ee933db43c`. LPM package version: `0.4.1`. Snapshot packages use an LPM packaging version, not an invented upstream release.

Encoding is not encryption.

See LICENSE.txt for upstream terms. Source files are included in this repository; installation does not run an external installer.
