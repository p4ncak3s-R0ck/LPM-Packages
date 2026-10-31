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

## Library catalog

The catalog covers all 29 approved library choices, plus CCryptolib as the ECNet2 dependency. The existing rxi JSON source is preserved. Every library includes its implementation, upstream license, usage example, revision and source hashes.

| Install name | Import | Purpose |
| --- | --- | --- |
| [basalt](basalt/README.md) | `basalt` | Full graphical application framework for CC:Tweaked |
| [basexx](basexx/README.md) | `basexx` | Base64, Base32, hex and other binary-text encodings |
| [bigfont](bigfont/README.md) | `bigfont` | Large terminal text using ComputerCraft drawing characters |
| [binaryheap](binaryheap/README.md) | `binaryheap` | Binary heaps and priority queues |
| [bump](bump/README.md) | `bump` | Spatial indexing and axis-aligned collision detection |
| [cbor](cbor/README.md) | `cbor` | CBOR binary serialization |
| [ccryptolib](ccryptolib/README.md) | `ccryptolib.sha256` | Cryptographic primitives required by ECNet2 |
| [cron](cron/README.md) | `cron` | Update-driven delayed and repeating callbacks |
| [csv](csv/README.md) | `csv` | CSV and delimited-text reading with an RFC-style row encoder |
| [deque](deque/README.md) | `deque` | Efficient double-ended queues |
| [dkjson](dkjson/README.md) | `dkjson` | JSON with explicit null preservation and formatted output |
| [ecnet2](ecnet2/README.md) | `ecnet2` | Encrypted modem connections for CC:Tweaked |
| [hump](hump/README.md) | `hump.timer`, `hump.signal`, `hump.vector` | Standalone timers, signals and two-dimensional vectors |
| [inifile](inifile/README.md) | `inifile` | INI configuration file parsing and writing |
| [inspect](inspect/README.md) | `inspect` | Readable nested-table output for debugging |
| [json](json/README.md) | `json` | Lightweight JSON encoding and decoding |
| [lume](lume/README.md) | `lume` | Table, string, collection and math utilities |
| [lust](lust/README.md) | `lust` | Unit tests, assertions and spies |
| [memoize](memoize/README.md) | `memoize` | Memoization of function results |
| [messagepack](messagepack/README.md) | `MessagePack`, `messagepack` | Compact MessagePack serialization |
| [middleclass](middleclass/README.md) | `middleclass` | Classes, inheritance and mixins |
| [moses](moses/README.md) | `moses` | Functional collection operations and chaining |
| [pine3d](pine3d/README.md) | `pine3d`, `Pine3D` | 3D rendering for CC:Tweaked terminals |
| [pixelbox-lite](pixelbox-lite/README.md) | `pixelbox_lite` | Teletext pixel graphics for terminals and monitors |
| [primeui](primeui/README.md) | `primeui` | Composable UI components for CC:Tweaked |
| [semver](semver/README.md) | `semver` | Semantic version parsing and comparison |
| [sha2](sha2/README.md) | `sha2` | Pure Lua SHA family hashes and HMAC |
| [stateful](stateful/README.md) | `stateful` | State-dependent behavior for Middleclass objects |
| [statemachine](statemachine/README.md) | `statemachine` | Finite state machines with transitions and callbacks |
| [tween](tween/README.md) | `tween` | Interpolation and easing of numerical properties |

Initialize a project once, then install libraries individually:

```sh
lpm init
lpm install basalt
lpm install dkjson
lpm install ecnet2
```

ECNet2 pulls in CCryptolib automatically; Stateful pulls in Middleclass. Libraries are loaded from the project directory using ordinary `require`, or through `lpm run`.

Basalt is the self-contained upstream **1.7.1** API, not Basalt 2. HUMP includes its standalone timer/signal/vector modules only. Both JSON libraries coexist under distinct names. The `pixelbox-lite` package imports as `pixelbox_lite`; MessagePack supports `MessagePack` and `messagepack`; Pine3D supports `pine3d` and `Pine3D`.

UI and graphics packages need the appropriate terminal/monitor; their event loops are interactive. Timers advance only when your program calls `update(dt)`. ECNet2 needs a modem, its daemon and explicit initialization of CCryptolib's random generator with a trusted entropy source. Installation does not start daemons, open modems, fetch runtime code, or modify startup programs.

`catalog.json` records exact upstream commits or SHA-256-pinned release artifacts, installed-source hashes, module names, dependencies and adaptations. Versions for untagged snapshots are **LPM packaging versions**, not claims of upstream release numbers. Existing license notices remain in source files and each license is also installed with its package. Do not remove upstream notices when distributing applications that embed these libraries.

## Validate the expanded catalog

```sh
python -m pip install lupa==2.8
python tools/check_catalog.py
LPM_ROOT=/absolute/path/to/LPM python tests/catalog.py
```

The integration suite uses LPM's actual resolver, installer, hash verification, exported loaders, lockfile and offline reinstall. It loads modules with the pinned CC:Tweaked `cc.require` implementation, tests the documented examples, exercises malformed serialization inputs, checks queue/timer behavior, and verifies hash vectors. Test-only ROM sources are fetched from one pinned commit and hash-checked; subsequent runs use a temporary cache.

The simulator accounts for Cobalt's large-number remainder and bit32 operand conversion behavior when initializing CCryptolib SHA constants; package source files remain unchanged. CC image/terminal/peripheral services are simulated. Tests do not replace an in-game check of interactive UI, monitor rendering, or real modem communication.
