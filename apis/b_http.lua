--[[
Http

Dependencies:
b_files

]]

--[[
Usage

- getData
Returns data from url or nil if error occured

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

function getData(url)
	local resp = http.get(url)
	if not resp then
		return nil
	else
		return resp.readAll()
	end
end