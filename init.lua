--[[
BlueAPI
March 22, 2015

http://pastebin.com/yy7gqfBQ
]]

local root = "blue-api"
local apis = fs.combine(root, "apis")

local function load(path, reset)
	if reset and _G[path] then
		os.unloadAPI(path)
	end
	return os.loadAPI(path)
end

local function loadNoLua(path, reset)
	local lua_path = path .. ".lua"
	if fs.exists(lua_path) then
		-- Delete old one
		if fs.exists(path) then
			fs.delete(path)
		end
		-- Use new one
		fs.move(lua_path, path)
	end

	return load(path, reset)
end

print("Initializing BlueAPI at " .. root)

loadNoLua(fs.combine(apis, "b_files"), true)
b_files.trimLuaExtDir(root, true)
shell.setAlias("blu", fs.combine(root, "init"))

load(fs.combine(apis, "b_api"), true)
b_api.setRoot(apis)

--

-- b_api.load("b_git")
-- b_git.install("blueberrys", "cc-blue-api", "master", "blue-api", print, {"README.md", "version"})
--
-- b_api.load("b_io")
-- b_io.pagedPrint("OK!")