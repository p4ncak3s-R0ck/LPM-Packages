"""Check vendored source, manifests, license files and Lua 5.2 syntax without network access."""
from pathlib import Path
import hashlib
import json
from lupa.lua52 import LuaRuntime
ROOT = Path(__file__).resolve().parents[1]

def main():
    lua = LuaRuntime(unpack_returned_tuples=True)
    compile_lua = lua.eval('function(s,n) local f,e=load(s,n,"t",{}); assert(f,e) end')
    entries = json.loads((ROOT / 'catalog.json').read_text())['packages']
    assert len(entries) == 30 and len({p['name'] for p in entries}) == 30
    count = 0
    for package in entries:
        directory = ROOT / package['name']
        assert package['revision'] and package['upstream'].startswith('https://')
        for filename,key in [('manifest.lua','manifest_sha256'),('LICENSE.txt','license_sha256')]:
            assert hashlib.sha256((directory/filename).read_bytes()).hexdigest()==package[key], f'{package["name"]}/{filename} changed without updating provenance'
        for record in package['files']:
            file = directory / record['file']
            assert file.is_relative_to(directory) and file.is_file()
            assert hashlib.sha256(file.read_bytes()).hexdigest() == record['sha256'], str(file)
            compile_lua(file.read_text(), '@' + str(file.relative_to(ROOT)))
            count += 1
        assert (directory/'README.md').is_file() and (directory/'example.lua').is_file()
        compile_lua((directory/'example.lua').read_text(), '@'+package['name']+'/example.lua')
    print(f'Verified {len(entries)} package manifests/licenses and {count} Lua source files')

if __name__ == '__main__':
    main()
