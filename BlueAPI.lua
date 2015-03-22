--[[
BlueAPI
Version 0.1
March 22, 2015
]]

local root = string.match(shell.getRunningProgram(), "(.-)([^//]-([^%.]+))$")

function load(module)
	_G[module] = nil
	return os.loadAPI(root .. module)
end

-- load("b_git")
-- b_git.install()

load("b_io")
print("ok? ", b_io)
b_io.pagedPrint("OK!")

