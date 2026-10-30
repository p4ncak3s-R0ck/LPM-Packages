# LPM Packages

Official package collection for [LPM](https://github.com/p4ncak3s-R0ck/LPM).

Install with `lpm install <name>` after `lpm init`.

Packages include DNS, DNS Server, DNS Records, RFS, RFS Client, RFS Server, Update and Updater. `hello.lua` demonstrates a standalone single-file application.

A package may use `<name>/manifest.lua`, `<name>/index.lua` plus manifests pinned to commits, or a standalone `<name>.lua` containing an LPM metadata comment. See the LPM documentation for package formats and proxy file sources.

## Test the package collection

Clone LPM alongside this repository, install Python's `lupa`, and set `LPM_ROOT` to the absolute root directory of the LPM checkout. Then run:

```sh
python dns-records/tests/run.py
python dns-records/tests/install.py
python rfs/tests/run.py
python updater/tests/run.py
```

The tests use a Lua 5.2 CC:Tweaked simulation. Runtime Rednet communication still requires CC:Tweaked computers in Minecraft.
