--[[
BlueAPI
Version 0.1
March 22, 2015
]]

local root = string.match(shell.getRunningProgram(), "(.-)([^//]-([^%.]+))$")

function load(module)
	_G[module] = nil

	local path = "root" .. module
	local success = os.loadAPI(path)
	if not success then
		path = "root" .. module .. ".lua"
		success = os.loadAPI(path)
	end

	return success
end

load("b_git")
-- b_git.install()

load("b_io")
b_io.pagedPrint("OK!")

