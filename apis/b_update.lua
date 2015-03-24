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
b_api.depend({"b_io", "b_http", "b_files"})

--

function checkUpdate(url, path)
	local new = b_http.getData(url)
	if not new then
		b_io.prn("Couldn't fetch " .. url)
		return false
	end
	print("OK1")

	local current = b_files.read(path)
	if not current then
		b_io.prn("No local version file found")
		return true
	end
	print("OK2")

	return (current < new)
end