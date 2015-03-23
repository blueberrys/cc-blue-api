--[[
GitHub installer

Inspired by GitGet (by apemanzilla)
http://www.computercraft.info/forums2/index.php?/topic/17387-gitget-lightweight-github-downloader-now-with-preset-mode/
http://pastebin.com/raw.php?i=6aMMzdwd

Dependencies:
b_files
]]

--[[
Usage

- install(username, repo, branch, path, printFn, exclude)
Username	- GitHub username
repo		- GitHub repo name
branch		- Github branch (default "master")
path		- Local install path (default "/")
printFn		- Status messages are sent to this function
exclude		- Table containing the relative path of folders/files to exclude
eg: install("blueberrys", "cc-blue-api", "master", "blue-api", print, {"README.md"})

]]

if not b_api then
	print("Could not load dependencies")
	print("Run \"blu\" for automatic dependency management")
	return
end
b_api.depend({"b_files"})

--

function install(username, repo, branch, path, printFn, exclude)
	branch = branch or "master"
	path = path or ""
	printFn = printFn or (function()end)

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
		printFn("Downloading JSON api (by ElvishJerricco)")
		b_files.write("json", http.get("http://pastebin.com/raw.php?i=4nRg9CHU").readAll())
		os.loadAPI("json")
	end

	printFn("Downloading files from GitHub")

	printFn("Fetching file list")
	-- https://api.github.com/repos/blueberrys/cc-blue-api/git/trees/master?recursive=1
	local fileList = "https://api.github.com/repos/" .. username .. "/" .. repo .. "/git/trees/" .. branch .. "?recursive=1"
	local data = json.decode(http.get(fileList).readAll())
	if data.message == "Not Found" then
		printFn("Invalid repository")
		return false
	end

	printFn("Gathering data")
	local treeNodes = {}
	local blobNodes = {}
	for _, node in pairs(data.tree) do
		if not should_exclude(node) then
			if node.type == "tree" then
				table.insert(treeNodes, node)
			elseif node.type == "blob" then
				table.insert(blobNodes, node)
			end
		end
	end

	printFn("Making directories")
	for _, node in pairs(treeNodes) do
		printFn("Creating " .. node.path)
		fs.makeDir(fs.combine(path, node.path))
	end

	printFn("Downloading files")
	local baseUrl = "https://raw.github.com/" .. username .. "/" .. repo .. "/" .. branch .. "/"
	local pendingUrls = {}
	for _, node in pairs(blobNodes) do
		printFn("Downloading " .. node.path)

		local url = baseUrl .. node.path
		pendingUrls[url] = true
		http.request(url)
	end

	printFn("Installing files")
	local pending = #blobNodes
	while (pending > 0) do
		local event, url, data = os.pullEvent()
		if (event == "http_success" or event == "http_failure") and pendingUrls[url] then

			local fileName = url:sub(baseUrl:len()+1)
			local filePath = fs.combine(path, fileName)
			if event == "http_success" then
				printFn("Installing " .. filePath)
				b_files.write(filePath, data.readAll())
			else
				printFn("Couldn't fetch " .. fileName)
			end

			pendingUrls[url] = nil
			pending = pending-1
		end -- if event
	end -- while pending

	printFn("Download complete")
end
