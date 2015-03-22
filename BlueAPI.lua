--[[
BlueAPI
Version 0.1
March 22, 2015
]]

local root = "blue-api/"

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
		local path2 = root .. module .. ".lua"
		if not fs.exists(path2) then
			return false
		end
		-- remove .lua ext
		fs.move(path2, path)
	end

	return os.loadAPI(path)
end

-- load("b_git")
-- b_git.install()

-- load("b_io")
-- b_io.pagedPrint("OK!")
