--[[
Startup

Dependencies:
b_files
]]


--[[
Usage

- addStartup(data)
Adds data to startup file, if it doesn't already contain the data

- removeStartup(data)
Removes specific data from startup file

- addAlias(alias, path)
Adds an alias to startup
Does not affect currently running instance (boot required)

- removeAlias(alias, path)
Removes alias from startup
Does not affect currently running instance (boot required)

]]

if not b_api then
	print("Could not load dependencies")
	print("Run \"blu\" for automatic dependency management")
	return
end
b_api.depend({"b_files"})

--

local line_feed = "\r\n"

function addStartup(data)
	if not b_files.hasData("startup", data) then
		b_files.createAppend("startup", line_feed .. data)
	end
end

function removeStartup(data)
	if b_files.hasData("startup", line_feed .. data) then
		data = line_feed .. data
	end
	b_files.removeData("startup", data)
end

function addAlias(alias, path)
	local cmd = "shell.setAlias(\"" .. alias .. "\",\"" .. path .. "\")"
	addStartup(cmd)
end

function removeAlias(alias, path)
	local cmd = "shell.setAlias(\"" .. alias .. "\",\"" .. path .. "\")"
	removeStartup(cmd)
end
