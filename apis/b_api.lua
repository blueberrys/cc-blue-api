--[[
API loading
]]

--[[
Usage

- setRoot(root)
Sets the root directory for loading api's
Use cautiously. Will affect all scripts using the api

- load(module, reset)
Loads the module from the current root directory
If reset is true, api will be forced to re-load

- loadBlue()
Loads all api's needed for blue-api
You can safely use setRoot after calling this

- depend(apis)
Loads all given apis
apis should be an object with api names as string elements

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
	if not fs.exists(path) then
		print(path .. " not found")
		return false
	end

	return os.loadAPI(path)
end

function loadBlue()
	for _, api in pairs(fs.list(root)) do
		load(api, true)
	end
end

function depend(apis)
	for _, a in pairs(apis) do
		if not _G[a] then
			load(a)
		end
	end
end