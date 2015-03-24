--[[
Startup

Dependencies:
b_files
]]


--[[
Usage

- addStartup(data)
Adds data to startup file, if it doesn't already contain the data

- addAlias(alias, path)
Adds an alias to startup
Does not affect currently running instance (boot required)

]]

if not b_api then
	print("Could not load dependencies")
	print("Run \"blu\" for automatic dependency management")
	return
end
b_api.depend({"b_files"})

--

function addStartup(data)
	local content = b_files.read("startup")
	if (content and content:find(data, 1, true)) then
		return false
	end
	
	b_files.createAppend("startup", data)
	return true
end

function addAlias(alias, path)
	local cmd = "shell.setAlias(\"" .. alias .. "\",\"" .. path .. "\")"
	addStartup("\n\n" ..  cmd)
end
