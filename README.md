# LPM Packages

Official package registry for [LPM](https://github.com/p4ncak3s-R0ck/LPM), the CC:Tweaked Lua package manager.

```text
lpm init
lpm install dns
lpm install rfs
lpm install hello
hello
```

Requires the LPM build with single-file packages (PR #8 or the merged main branch).

| Package | Purpose |
| --- | --- |
| `dns` | Authenticated DNS over Rednet |
| `dns-server` | DNS server application |
| `dns-records` | DNS record editor |
| `rfs` | Rednet file sharing library |
| `rfs-client` | RFS client command |
| `rfs-server` | RFS server command |
| `updater` | DNS/RFS root-file updater library |
| `update` | Root-file updater command |
| `lpm` | LPM package manager |
| `hello` | Standalone single-file application example |

Each `<name>.lua` is either a literal package manifest or a standalone Lua program with an LPM metadata comment. Proxy manifests pin source files to immutable commits in the LPM source repository and include SHA-256 checksums. Package definitions live here; source history and implementation remain in LPM. Manifests are parsed as data, never executed during installation. See the [package format documentation](https://github.com/p4ncak3s-R0ck/LPM/blob/main/lpm/README.md).

Package downloads require HTTP access to `api.github.com` and `raw.githubusercontent.com`. Runtime Rednet services require modems and configured CC:Tweaked computers.
