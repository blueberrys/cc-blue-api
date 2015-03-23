--[[
API loading
]]

--[[
Usage

- setRoot(root)
Sets the root directory for loading api's

- load(module, reset)
Loads the module from the current root directory
If reset is true, api will be forced to re-load

]]

local root = "/"

function setRoot(r)
	root = r
end

function load(module, reset)
	if _G[module] then
		if not reset then
			return true
		else
			os.unloadAPI(module)
		end
	end

	local path = fs.combine(root, module)

	return os.loadAPI(path)
end