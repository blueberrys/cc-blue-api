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

if not b_api then
	print("Could not load dependencies")
	print("Run \"blu\" for automatic dependency management")
	return
end
b_api.depend({"b_files"})

--

function getData(url)
	local resp = http.get(url)
	if not resp then
		return resp
	else
		return resp.readAll()
	end
end

function getDownload(url, file)
	local data = getData(url)
	if data then
		return b_files.write("json", data)
	end
	return false
end