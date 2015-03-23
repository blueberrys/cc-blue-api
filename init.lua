--[[
BlueAPI
Version 0.1
March 22, 2015
]]

local root = "blue-api"
local apis = fs.combine(root, "apis")

local function loadNoLua(path)
	local lua_path = path .. ".lua"
	if fs.exists(lua_path) then
		fs.move(lua_path, path)
	end
	return os.loadAPI(path)
end

loadNoLua(fs.combine(apis, "b_files"))
b_files.trimLuaExtDir(root, true)

shell.setAlias("blu", fs.combine(root, "init"))

--

-- os.loadAPI("b_api")
-- b_api.setRoot(apis)
--
-- b_api.load("b_git")
-- b_git.install()
--
-- b_api.load("b_io")
-- b_io.pagedPrint("OK!")
