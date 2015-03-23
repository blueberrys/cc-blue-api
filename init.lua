--[[
BlueAPI
Version 0.1
March 22, 2015
]]

local root = "blue-api/apis"

local function loadNoLua(path)
	local lua_path = path .. ".lua"
	if fs.exists(lua_path) then
		fs.move(lua_path, path)
	end
	return os.loadAPI(path)
end

loadNoLua(fs.combine(root, "b_files"))
b_files.trimLuaExtDir(root, true)

--

-- os.loadAPI("b_api")
-- b_api.setRoot(root)
--
-- b_api.load("b_git")
-- b_git.install()
--
-- b_api.load("b_io")
-- b_io.pagedPrint("OK!")
