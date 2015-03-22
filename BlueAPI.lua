--[[
BlueAPI
Version 0.1
March 22, 2015
]]

local root = shell.resolve("blue-api")

function load(module)
	return os.loadAPI(root .. "/" .. module)
end

load("b_git")
-- b_git.install()

load("b_io")
b_io.pagedPrint("OK!")


