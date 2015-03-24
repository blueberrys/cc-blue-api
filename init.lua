--[[
BlueAPI
March 22, 2015

http://pastebin.com/yy7gqfBQ
]]

local user = "blueberrys"
local repo = "cc-blue-api"
local exclFiles = {
	"README.md",
}

local root = "blue-api"
local apis = fs.combine(root, "apis")
local versionUrl = "https://raw.githubusercontent.com/blueberrys/cc-blue-api/master/version"
local versionPath = fs.combine(root, "version")

local force_reset = true

--

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

--

print("Initializing BlueAPI at " .. root)

loadNoLua(fs.combine(apis, "b_files"), force_reset)
b_files.trimLuaExtDir(root, true)

load(fs.combine(apis, "b_api"), force_reset)
b_api.setRoot(apis)

b_api.load("b_update", force_reset)
b_update.gitUpdate(user, repo, "master", root, exclFiles)

b_api.load("b_startup", force_reset)
local alias, run = "blu", fs.combine(root, "init")
b_startup.addAlias(alias, run)
shell.setAlias(alias, run)
