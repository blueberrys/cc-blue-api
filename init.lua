--[[
BlueAPI
Version 0.1
March 22, 2015
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
		fs.move(lua_path, path)
	end

	return load(path, reset)
end

loadNoLua(fs.combine(apis, "b_files"), true)
b_files.trimLuaExtDir(root, true)
shell.setAlias("blu", fs.combine(root, "init"))

load(fs.combine(apis, "b_api"), true)
b_api.setRoot(apis)

--

b_api.load("b_git")
b_git.install("blueberrys", "cc-blue-api", "master", print, {"README.md"})

-- b_api.load("b_io")
-- b_io.pagedPrint("OK!")




