--[[
BlueAPI
Version 0.1
March 22, 2015
]]

local root = shell.resolve("blue-api")

function load(module)
	return os.loadAPI(root .. "/" .. module)
end

b = {}

b_gi = load("GitInstaller")
-- b_gi.git_install()

b_io = load("IO")
b_io.pagedPrint("OK!")

