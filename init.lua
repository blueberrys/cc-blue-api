--[[
BlueAPI initialization

Loads b_api and b_files
Trims lua extensions
Checks for updates
Sets "blu" alias for self

Parameters
noUpdate - Prevents automatic update check
]]

local user = "blueberrys"
local repo = "cc-blue-api"
local exclFiles = {
	"README.md",
	"pastebin",
}

local root = "blue-api"

local apis = fs.combine(root, "apis")

local alias, run = "blu", fs.combine(root, "init")

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

local canUpdate = true

local arg = {...}
for _, a in pairs(arg) do
	if a == "noUpdate" then
		canUpdate = false
	end
end

--

print("Initializing BlueAPI at " .. root)

-- Load b_files, trim lua
loadNoLua(fs.combine(apis, "b_files"), force_reset)
b_files.trimLuaExtDir(root, true)

-- Load b_api
load(fs.combine(apis, "b_api"), force_reset)
b_api.setRoot(apis)

if canUpdate then
	-- Load b_update, check for updates
	b_api.load("b_update", force_reset)
	b_update.gitUpdate(user, repo, "master", root, exclFiles)
end

-- Load b_startup, set alias
b_api.load("b_startup", force_reset)
b_startup.addAlias(alias, run)
shell.setAlias(alias, run)
