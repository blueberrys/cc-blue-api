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
shell.setAlias("blu", fs.combine(root, "init"))

load(fs.combine(apis, "b_api"), force_reset)
b_api.setRoot(apis)

--

b_api.load("b_update", force_reset)
print("Checking for updates")
local should_update, new, current = b_update.checkUpdate(versionUrl, versionPath)
if should_update then
	print("Update available!")
	print("Latest ver: ".. new)
	if current then print("Current ver: ".. current) end
	-- TODO: Ask to update

	b_api.load("b_git")
	b_git.install(user, repo, "master", root, print, exclFiles)
	shell.run(fs.combine(root, "init.lua"))
else
	print("")
end

--

-- b_api.load("b_git")
-- b_git.install("blueberrys", "cc-blue-api", "master", "blue-api", print, {"README.md", "version"})
--
-- b_api.load("b_io")
-- b_io.pagedPrint("OK!")
