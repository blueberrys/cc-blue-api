--[[
Updater

Dependencies:
b_files
]]

--[[
Usage

- checkUpdate(url, path)
Returns true if update is available

]]

if not b_api then
	print("Could not load dependencies")
	print("Run \"blu\" for automatic dependency management")
	return
end
b_api.depend({"b_files"})

--

function checkUpdate(url, path)
	local resp = http.get(url)
	if not resp then
		print("Couldn't fetch " .. url)
		return false
	end
	
	local new = resp.readAll()
	local current = 0
end









