-- Appended to LPM's existing simulated filesystem and HTTP harness.
local ccExpect=assert(load(REAL_EXPECT,'@cc.expect','t',_G))()
local oldRequire=require
function require(name)
    if name=='cc.expect' then return ccExpect end
    return oldRequire(name)
end
local dependencies={}
local expectedFileCount=0
for name, contents in pairs(CATALOG) do
    dependencies[name]='*'
    local manifest=data.parse(contents['manifest.lua'])
    responses[raw(tip,name..'/manifest.lua')]=contents['manifest.lua']
    for source in pairs(manifest.files) do
        expectedFileCount=expectedFileCount+1
        assert(contents[source], 'Missing package source '..name..'/'..source)
        responses[raw(tip,name..'/'..source)]=contents[source]
    end
end
local locked
check('All 30 catalog packages install together without export collisions',function()
    setup(dependencies)
    locked=core.install('project')
    assert(core.verify('project')==expectedFileCount)
    assert(locked.packages.ecnet2.manifest.dependencies.ccryptolib)
    assert(locked.packages.stateful.manifest.dependencies.middleclass)
    for name in pairs(dependencies) do
        assert(fs.exists('project/.lpm/current/packages/'..name..'/LICENSE.txt'))
    end
end)

-- Cobalt uses Java remainder for these powers. Stock Lua 5.2's floor-based
-- modulo cancels the remainder above 2^53 and loops forever in this upstream
-- constant generator. Emulate Cobalt at load time in the simulator only; the
-- installed source and its verified hash are not changed.
local previousLoadfile=loadfile
function loadfile(path,mode,scope)
    local source=files[norm(path)]
    if source and path:match('ccryptolib/sha256%.lua$') then
        source=source:gsub('2 %^ p %% p','math.fmod(2 ^ p, p)')
        return load(source,'@'..path,mode,scope)
    end
    return previousLoadfile(path,mode,scope)
end
local drawCalls=0
local function terminal(w,h)
    local x,y,bg,fg=1,1,32768,1
    local t={}
    function t.getSize() return w or 51,h or 19 end
    function t.isColor() return true end
    t.isColour=t.isColor
    function t.getCursorPos() return x,y end
    function t.setCursorPos(a,b) x,y=a,b end
    function t.getBackgroundColor() return bg end
    t.getBackgroundColour=t.getBackgroundColor
    function t.getTextColor() return fg end
    t.getTextColour=t.getTextColor
    function t.setBackgroundColor(v) bg=v end
    t.setBackgroundColour=t.setBackgroundColor
    function t.setTextColor(v) fg=v end
    t.setTextColour=t.setTextColor
    function t.blit(text,front,back)
        assert(type(text)=='string' and #text==#front and #text==#back,'Invalid terminal blit')
        drawCalls=drawCalls+1
    end
    function t.write(s) assert(type(s)=='string'); drawCalls=drawCalls+1 end
    function t.getLine() return (' '):rep(w or 51),('0'):rep(w or 51),('f'):rep(w or 51) end
    function t.getPaletteColor() return 0,0,0 end
    t.getPaletteColour=t.getPaletteColor
    t.nativePaletteColor=t.getPaletteColor
    t.nativePaletteColour=t.getPaletteColor
    for _,n in ipairs({'clear','clearLine','scroll','setCursorBlink','setPaletteColor','setVisible','redraw','restoreCursor','reposition'}) do t[n]=function() end end
    t.setPaletteColour=t.setPaletteColor
    function t.current() return t end
    function t.native() return t end
    function t.getPosition() return 1,1 end
    function t.getCursorBlink() return false end
    function t.redirect() return t end
    return t
end
local colors={}
for i,n in ipairs({'white','orange','magenta','lightBlue','yellow','lime','pink','gray','lightGray','cyan','purple','blue','brown','green','red','black'}) do colors[n]=2^(i-1) end
colors.grey=colors.gray; colors.lightGrey=colors.lightGray
function colors.toBlit(c) return ('0123456789abcdef'):sub(math.log(c)/math.log(2)+1,math.log(c)/math.log(2)+1) end
function colors.nativePaletteColor()return 0,0,0 end
colors.nativePaletteColour=colors.nativePaletteColor
function colors.combine(...) local v=0;for _,n in ipairs({...}) do v=bit32.bor(v,n) end; return v end
function colors.unpackRGB(c) return bit32.extract(c,16,8)/255,bit32.extract(c,8,8)/255,bit32.extract(c,0,8)/255 end
function colors.packRGB(r,g,b) return math.floor(r*255)*65536+math.floor(g*255)*256+math.floor(b*255) end
local function environment()
    local env={}
    local blocked={debug=true,python=true}
    setmetatable(env,{__index=function(_,k) if not blocked[k] then return _G[k] end end})
    env._G=env
    -- Cobalt truncates numeric bit32 operands; stock Lua 5.2 rounds them.
    env.bit32={}
    for name,fn in pairs(bit32) do
        env.bit32[name]=function(...)
            local args={...}
            for i,v in ipairs(args) do args[i]=math.modf(v) end
            return fn(table.unpack(args))
        end
    end
    files["rom/modules/main/cc/expect.lua"]=REAL_EXPECT
    env.dofile=function(path)
        if path=="rom/modules/main/cc/require.lua" then return require("cc.require") end
        return assert(loadfile(path,"t",env))()
    end
    env.string={};for k,v in pairs(string) do if k~='dump' then env.string[k]=v end end
    env.os={clock=os.clock,time=function()return 12 end,day=function()return 1 end,epoch=function()return 1700000000000 end,
        getComputerID=function()return 1 end,queueEvent=function()end,startTimer=function()return 1 end,cancelTimer=function()end,
        pullEvent=function()error('Unexpected blocking event call in smoke test')end}
    env.term=terminal();env.colors=colors;env.colours=colors
    env.window={create=function(_,_,_,w,h)return terminal(w,h)end}
    env.peripheral={getType=function()end,find=function()end,getNames=function()return {}end,getMethods=function()return {}end}
    env.keys={enter=28,space=57,left=203,right=205,up=200,down=208,backspace=14,tab=15}
    env.parallel={waitForAny=function()error('Unexpected blocking loop in smoke test')end}
    env.paintutils={};env.settings={get=function(_,d)return d end}
    env.io={type=io.type,open=function()error('Filesystem io is not used by these memory smoke tests')end}
    env.sleep=function()error('Unexpected sleep in smoke test')end
    env.require,env.package=require('cc.require').make(env,'project')
    local loaded=env.package.loaded
    for k in pairs(loaded) do loaded[k]=nil end
    loaded._G=env;loaded.package=env.package
    for _,k in ipairs({'table','string','math','coroutine','bit32','os','io'}) do loaded[k]=env[k] end
    loaded['cc.expect']=ccExpect
    loaded['cc.image.nft']={draw=function()end}
    return env
end
local env=environment()
local req=env.require
for name in pairs(CATALOG) do
    print('Loading '..name)
    check('Load catalog package '..name,function()
        debug.sethook(function() error('Library exceeded smoke-test instruction limit: '..name) end,'',20000000)
        local m=locked.packages[name].manifest
        for module in pairs(m.modules) do assert(req(module)~=nil,module) end
        debug.sethook()
    end)
end
check('Run all 30 documented examples through installed exports',function()
    for name,content in pairs(CATALOG) do
        local example=content['example.lua']
        if name=='basalt' then example=example:gsub('basalt.autoUpdate%(%)','') end -- event loop is interactive
        local fn=assert(load(example,'@'..name..'/example.lua','t',env))
        local ok,err=pcall(fn);assert(ok,name..': '..tostring(err))
    end
end)
check('JSON malformed input, Unicode and explicit null behavior',function()
    local json=req('json');local dk=req('dkjson')
    assert(json.decode('"\\u0041"')=='A')
    assert(not pcall(json.decode,'{"x":'))
    local v=dk.decode('[null,false]',1,dk.null);assert(v[1]==dk.null and v[2]==false)
    local value,_,err=dk.decode('{"x":');assert(value==nil and err)
end)
check('Binary formats round-trip nested objects, binary strings and floating values',function()
    for _,name in ipairs({'MessagePack','cbor'}) do
        local m=req(name);local encode=m.pack or m.encode;local decode=m.unpack or m.decode
        local t=decode(encode({negative=-5,fraction=1.25,flag=false,bytes='a\0b',array={1,2,3}}))
        assert(t.negative==-5 and t.fraction==1.25 and t.flag==false and t.bytes=='a\0b' and t.array[3]==3)
        assert(not pcall(decode,string.char(129)))
    end
end)
check('Base encodings handle zero bytes and invalid inputs',function()
    local b=req('basexx');local s='\0hello\255'
    assert(b.from_base64(b.to_base64(s))==s)
    assert(b.from_hex(b.to_hex(s))==s)
    assert(b.from_base64('?')==nil)
end)
check('INI final line and CSV quoting, newlines and invalid shapes',function()
    local ini=req('inifile');assert(ini.parse('[x]\ny=4','memory').x.y==4)
    local csv=req('csv');local text=csv.encode({{'a,b','a"b','a\nb','',false}})
    local row=csv.openstring(text,{separator=','}):lines()()
    assert(row[1]=='a,b' and row[2]=='a"b' and row[3]=='a\nb' and row[4]=='' and row[5]=='false')
    assert(not pcall(csv.encode,{{1,2},{3}}))
    assert(not pcall(csv.encode,{{math.huge}}))
    assert(not pcall(csv.encode,{bad={1}}))
end)
check('Hash and HMAC known-answer vectors',function()
    local s=req('sha2')
    assert(s.sha256('abc')=='ba7816bf8f01cfea414140de5dae2223b00361a396177a9cb410ff61f20015ad')
    assert(s.hmac(s.sha256,string.char(11):rep(20),'Hi There')=='b0344c61d8db38535ca8afceaf0bf12b881dc200c9833da726e9376c2e32cff7')
    local sha=req('ccryptolib.sha256');local util=req('ccryptolib.util')
    assert(util.toHex(sha.digest('abc'))==s.sha256('abc'))
end)
check('Queue order, heap order and memoization cache behavior',function()
    local d=req('deque'):new();d:append(2);d:unshift(1);assert(d:shift()==1 and d:pop()==2 and d:isEmpty())
    d:append('a');d:append('b');assert(d:find('b')==2)
    local h=req('binaryheap').minHeap();for _,v in ipairs({4,1,3,2}) do h:insert(v) end
    for i=1,4 do assert(h:pop()==i) end
    local n=0;local f=req('memoize')(function(x)n=n+1;return x*2 end);assert(f(3)==6 and f(3)==6 and n==1)
end)
check('Signals, timers and collision queries produce meaningful results',function()
    local signal=req('hump.signal').new();local n=0
    signal:register('tick',function(x)n=n+x end);signal:emit('tick',3);assert(n==3)
    local timer=req('hump.timer').new();timer:after(1,function()n=n+1 end);timer:update(0.5);assert(n==3);timer:update(0.6);assert(n==4)
    local world=req('bump').newWorld(16);world:add('a',0,0,2,2);world:add('b',3,0,2,2)
    local x,_,_,len=world:move('a',4,0);assert(x==1 and len==1)
end)
check('Lume trace works without a debug API',function()req('lume').trace('ready')end)
check('UI and graphics examples reached the terminal',function()assert(drawCalls>0)end)
check('ECNet2 address codec, modem status and random initialization guard',function()
    local ec=req('ecnet2');assert(ec.ANONYMOUS.address==('A'):rep(43)..'=')
    assert(not ec.isOpen('left'))
    local random=req('ccryptolib.random');assert(not pcall(random.random,32))
end)
check('Locked offline reinstall verifies all catalog package contents',function()
    offline=true;core.install('project',nil,false,false,true);assert(core.verify('project')==expectedFileCount);offline=false
end)
check('Deque operations agree with a plain-array model',function()
    local d=req('deque'):new();local model={};local seed=17
    local function random(n)seed=(seed*16807)%2147483647;return seed%n+1 end
    for i=1,1000 do
        local op=random(6)
        if op==1 then d:append(i);model[#model+1]=i
        elseif op==2 then d:unshift(i);table.insert(model,1,i)
        elseif op==3 then assert(d:shift()==table.remove(model,1))
        elseif op==4 then assert(d:pop()==table.remove(model))
        elseif op==5 then local idx=random(#model+1);d:insert(i,idx);table.insert(model,idx,i)
        elseif #model>0 then local idx=random(#model);assert(d:remove(idx)==table.remove(model,idx)) end
        assert(#d==#model)
        for j,v in ipairs(model) do assert(d[j]==v) end
    end
end)
check('ECNet2 cipher states authenticate associated data and reject tampering',function()
    local Cipher=req('ecnet2.cipher_state');local key=('k'):rep(32)
    -- Stock Lua 5.2 has no CraftOS string:pack extension. This test only
    -- needs its little-endian 12-byte integer nonce representation.
    local pack,fmt=req('ccryptolib.internal.packing').compilePack('<I12')
    local originalPack=string.pack
    string.pack=function(pattern,n)assert(pattern=='<I12');return pack(fmt,n)end
    local send,receive=Cipher(key),Cipher(key)
    local ciphertext=send:encryptWithAd('header','secret')
    assert(ciphertext~='secret' and receive:decryptWithAd('header',ciphertext)=='secret')
    local bad=Cipher(key)
    assert(bad:decryptWithAd('wrong-header',ciphertext)==nil)
    local tampered=Cipher(key)
    assert(tampered:decryptWithAd('header',ciphertext:sub(1,-2)..string.char((ciphertext:byte(-1)+1)%256))==nil)
    string.pack=originalPack
end)
local packageNames={}
for name in pairs(CATALOG) do packageNames[#packageNames+1]=name end
table.sort(packageNames)
for _,name in ipairs(packageNames) do
    check('Isolated install and module loading: '..name,function()
        setup({[name]='*'})
        local lock=core.install('project')
        local count=0;for _ in pairs(lock.packages) do count=count+1 end
        assert(count==((name=='ecnet2' or name=='stateful') and 2 or 1))
        assert(core.verify('project')>0)
        local isolated=environment()
        for module in pairs(lock.packages[name].manifest.modules) do assert(isolated.require(module)) end
    end)
end
print('Catalog integration checks passed ('..tests..' groups including LPM)')
