--[[
Http

Dependencies:
b_files
]]

--[[
Usage

]]

local function depend(apis)
	if not b_api then
		print("Could not load dependencies")
		print("Run \"blu\" for automatic dependency management")
		return false
	end

	for _, d in pairs(apis) do
		if not _G[d] then
			b_api.load(d)
		end
	end
end

depend({"b_files"})

--
