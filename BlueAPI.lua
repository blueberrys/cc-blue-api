--[[
BlueAPI
Version 0.1
March 22, 2015
]]

local root = string.match(shell.getRunningProgram(), "(.-)([^//]-([^%.]+))$")

function load(module, reset)
	if _G[module] then
		if not reset then
			return true
		else
			_G[module] = nil
		end
	end

	local path = root .. module
	if not fs.exists(path) then
		path = root .. module .. ".lua"
		if not fs.exists(path) then
			return false
		end
	end

	return os.loadAPI(path)
end

load("b_git")
b_git.install()

load("b_io")
b_io.pagedPrint("OK!")
