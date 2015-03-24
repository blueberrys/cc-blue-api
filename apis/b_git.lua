--[[
GitHub installer

Inspired by GitGet (by apemanzilla)
http://www.computercraft.info/forums2/index.php?/topic/17387-gitget-lightweight-github-downloader-now-with-preset-mode/
http://pastebin.com/raw.php?i=6aMMzdwd

Dependencies:
b_files
b_http
b_io
]]

--[[
Usage

- install(username, repo, branch, path, exclude)
Username	- GitHub username
repo		- GitHub repo name
branch		- Github branch (default "master")
path		- Local install path (default "/")
exclude		- Table containing the relative path of folders/files to exclude
eg: install("blueberrys", "cc-blue-api", "master", "blue-api", print, {"README.md"})

]]

if not b_api then
	print("Could not load dependencies")
	print("Run \"blu\" for automatic dependency management")
	return
end
b_api.depend({"b_files", "b_http", "b_io"})

--

local maxAttempt = 3

function install(username, repo, branch, path, exclude)
	branch = branch or "master"
	path = path or ""
	
	local function should_exclude(node)
		for _, ePath in pairs(exclude) do
			if node.type == "tree" then
				if ePath == node.path then
					return true
				end
			elseif node.type == "blob" then
				local eLen = ePath:len()
				if (ePath == node.path:sub(1, eLen)) then
					return true
				end
			end
		end

		return false
	end

	if not json then
		b_io.prnt("Downloading JSON api (by ElvishJerricco)")
		b_http.getDownload("http://pastebin.com/raw.php?i=4nRg9CHU", "json")
		os.loadAPI("json")
	end

	b_io.prnt("Downloading files from GitHub")
	
	b_io.prnt("Fetching file list")
	-- https://api.github.com/repos/blueberrys/cc-blue-api/git/trees/master?recursive=1
	local fileList = "https://api.github.com/repos/" .. username .. "/" .. repo .. "/git/trees/" .. branch .. "?recursive=1"
	local data = b_http.getData(fileList)
	if not data then
		b_io.prnt("Invalid repository")
		return false
	end
	local jsonData = json.decode(data)
	if jsonData.message == "Not Found" then
		b_io.prnt("Invalid repository")
		return false
	end

	b_io.prnt("Gathering data")
	local treeNodes = {}
	local blobNodes = {}
	for _, node in pairs(jsonData.tree) do
		if not should_exclude(node) then
			if node.type == "tree" then
				table.insert(treeNodes, node)
			elseif node.type == "blob" then
				table.insert(blobNodes, node)
			end
		end
	end

	b_io.prnt("Making directories")
	for _, node in pairs(treeNodes) do
		b_io.prnt("Creating " .. node.path)
		fs.makeDir(fs.combine(path, node.path))
	end

	b_io.prnt("Downloading files")
	local baseUrl = "https://raw.github.com/" .. username .. "/" .. repo .. "/" .. branch .. "/"
	local pendingUrls = {}
	for _, node in pairs(blobNodes) do
		b_io.prnt("Downloading " .. node.path)

		local url = baseUrl .. node.path
		pendingUrls[url] = true
		http.request(url)
	end

	b_io.prnt("Installing files")
	local pending = #blobNodes
	local attempts = {}
	while (pending > 0) do
		local event, url, data = os.pullEvent()
		if (event == "http_success" or event == "http_failure") and pendingUrls[url] then
			pendingUrls[url] = nil
			pending = pending - 1

			local fileName = url:sub(baseUrl:len()+1)
			local filePath = fs.combine(path, fileName)

			if event == "http_success" then
				b_io.prnt("Installing " .. filePath)
				b_files.write(filePath, data.readAll())
			else
				b_io.prnt("Couldn't fetch " .. fileName)

				local atmp = attempts[fileName] or 0
				atmp = atmp + 1
				attempts[fileName] = atmp

				if atmp < maxAttempt then
					b_io.prnt("Retrying. Attempt: " .. atmp)
					pendingUrls[url] = true
					pending = pending + 1
					http.request(url)
				end -- attempt
			end -- success/fail

		end -- if event
	end -- while pending

	b_io.prnt("Download complete")
end
