#!/usr/bin/env lua5.3
os.execute('sudo rm -rf /usr/lib/x86_64-linux-gnu/lua/5.3/tdlua.so')
os.execute('sudo rm -rf /usr/local/share/lua/5.3/tdLua.lua')
local so_path_file = {'/usr','lib','x86_64-linux-gnu','lua','5.3','tdlua.so'}
local tdbot_client_path = {'/usr','local','share','lua','5.3','tdLua.lua'}
function exists(file_path)
 local ok, err, code = os.rename(file_path, file_path)
 if not ok then
if code == 13 then
 return true
end
 end
 return ok, err
end
local function rem_and_create_dir(tab)
os.remove(table.concat(tab, '/'))
for folder = 1, 5 do
local path = tab[1]
for level = 2, folder do
path = path ..'/'.. tab[level]
end
if not exists(path) then
os.execute('sudo mkdir '..path)
end
end
end
if os.execute('unzip tdlua.zip') then
rem_and_create_dir(so_path_file)
os.execute('sudo mv tdlua.so ' .. table.concat(so_path_file, '/'))
rem_and_create_dir(tdbot_client_path)
os.execute('sudo mv tdLua.lua ' .. table.concat(tdbot_client_path, '/'))
os.execute('sudo rm -rf tdlua.zip')
if exists(table.concat(so_path_file, '/')) and exists(table.concat(tdbot_client_path, '/')) then
os.execute('sudo lua5.3 start.lua')
end
end