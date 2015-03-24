--[[
Updater


Dependencies:
b_io
b_http
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
local ok = b_api.depend({"b_io", "b_http", "b_files"})
print("DEPENDING ", ok)

--

function checkUpdate(url, path)
	local new = b_http.getData(url)
	if not new then
		b_io.prn("Couldn't fetch " .. url)
		return false
	end

	local current = b_files.read(path)
	if not current then
		b_io.prn("No local version file found")
		return true
	end

	return (current < new)
end