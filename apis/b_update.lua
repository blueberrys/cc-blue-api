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
Returns: should_update, new, current
should_update is true if new is greater than current, or current unavailable
current is not returned if unavailable

- gitUpdate(username, repo, branch, path, exclFiles)
Updates a complete repository from GitHub
Requires a "version" file to be in the root folder at the repository
See b_git.install for more info on params

]]

if not b_api then
	print("Could not load dependencies")
	print("Run \"blu\" for automatic dependency management")
	return
end
b_api.depend({"b_files", "b_git", "b_http", "b_io"})

--

function checkUpdate(url, path)
	local new = b_http.getData(url)
	if not new then
		b_io.prnt("Couldn't fetch " .. url)
		return false
	end

	local current = b_files.read(path)
	if not current then
		b_io.prnt("No local version file found")
		return true, new
	end

	return (current < new), new, current
end

function gitUpdate(username, repo, branch, path, exclFiles)
	local updateUrl = "https://raw.githubusercontent.com/" .. username .. "/" .. repo .. "/" .. branch .. "/version"
	local updatePath = fs.combine(path, "version")
	
	b_io.prnt("Checking for updates")
	if checkUpdate(updateUrl, updatePath) then
		b_io.prnt("Downloading latest version")
		b_git.install(username, repo, branch, path, exclFiles)
	end
end