"""Install the complete catalog with LPM, then exercise it in a Lua 5.2 CraftOS simulation.

LPM_ROOT must point to a current LPM checkout. Test-only CraftOS sources are
fetched from one pinned upstream commit and verified by SHA-256 before use.
No installed package downloads code or invokes an upstream installer at runtime.
"""
from pathlib import Path
from urllib.request import urlopen
import hashlib
import json
import os
import tempfile
from lupa.lua52 import LuaRuntime

ROOT = Path(__file__).resolve().parents[1]
LPM = Path(os.environ.get('LPM_ROOT', ROOT.parent / 'LPM')).resolve()
CC_COMMIT = 'e49896848178be8d8aa7f146a3893e9ae1d87d58'
CC_BASE = f'https://raw.githubusercontent.com/cc-tweaked/CC-Tweaked/{CC_COMMIT}/projects/core/src/main/resources/data/computercraft/lua/rom/modules/main/cc/'


def rom_source(name):
    lock = json.loads((ROOT / 'tests/rom-lock.json').read_text())
    cache = Path(tempfile.gettempdir()) / ('lpm-catalog-cc-' + CC_COMMIT)
    cache.mkdir(exist_ok=True)
    target = cache / (name + '.lua')
    if not target.exists():
        target.write_bytes(urlopen(CC_BASE + name + '.lua', timeout=30).read())
    content = target.read_bytes()
    assert hashlib.sha256(content).hexdigest() == lock[name], 'Changed test ROM source: ' + name
    return content.decode()


def main():
    catalog = json.loads((ROOT / 'catalog.json').read_text())['packages']
    assert len(catalog) == 30
    runtime = LuaRuntime(unpack_returned_tuples=True)
    packages = runtime.table()
    for item in catalog:
        directory = ROOT / item['name']
        sourcefiles = runtime.table()
        for file in directory.rglob('*'):
            if file.is_file():
                sourcefiles[file.relative_to(directory).as_posix()] = file.read_text()
        for record in item['files']:
            actual = hashlib.sha256((directory / record['file']).read_bytes()).hexdigest()
            assert actual == record['sha256'], 'Provenance mismatch: ' + item['name']
        packages[item['name']] = sourcefiles
    runtime.globals().CATALOG = packages
    runtime.globals().REAL_EXPECT = rom_source('expect')
    # Cobalt accepts this spelling; stock Lua 5.2 requires the equivalent %%.
    runtime.globals().realRequireSource = rom_source('require').replace('sep:gsub("%.", "%%%.")', 'sep:gsub("%.", "%%.")')
    os.chdir(LPM)
    harness = (LPM / 'tests/test.lua').read_text()
    runtime.execute(harness + '\n' + (ROOT / 'tests/catalog.lua').read_text())


if __name__ == '__main__':
    main()
