# csv

CSV and delimited-text reading with an RFC-style row encoder.

```sh
lpm install csv
```

```lua
local csv = require("csv")
local encoded = csv.encode({{"name", "count"}, {"a,b", 3}})
for row in csv.openstring(encoded, {separator = ","}):lines() do
    print(table.concat(row, " | "))
end
```

Upstream: https://github.com/geoffleyland/lua-csv

Revision: `09557e4608b02d136b9ae39a8fa0f36328fa1cec`. LPM package version: `0.1.0`. Snapshot packages use an LPM packaging version, not an invented upstream release.

Upstream lua-csv provides the reader. LPM adds csv.encode(rows) for rectangular arrays of strings, finite numbers and booleans; comma-separated CRLF output doubles embedded quotes. Files use the standard CraftOS io API.

See LICENSE.txt for upstream terms. Source files are included in this repository; installation does not run an external installer.

LPM adaptation: The encoder rejects sparse or keyed top-level row collections as well as inconsistent cells.
