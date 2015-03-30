--[[
BlueAPI Installer
Version 1.2

Installs BlueAPI
]]

--[[
Usage:

pastebin run yy7gqfBQ [files..]

Files should be relative paths of additional files to download
If blank, all files will be downloaded
Custom installation is slower because it uses synchronous http
Only use it if you need a few files

]]

local user = "blueberrys"
local repo = "cc-blue-api"

local minFiles = {
	"init.lua",
	"version",
	"apis/b_api.lua",
	"apis/b_files.lua",
	"apis/b_git.lua",
	"apis/b_http.lua",
	"apis/b_io.lua",
	"apis/b_startup.lua",
	"apis/b_update.lua",
}
local exclFiles = {
	"README.md",
	"pastebin",
}

local dir = "blue-api"
local run = fs.combine(dir, "init.lua")
-- local alias = "blu"

local custom
local params = {...}
for _, a in pairs(params) do
	if not custom then
		custom = {}
	end
	table.insert(custom, a)
end

--

local function install(username, repo, branch, files, path)
	branch = branch or "master"
	path = path or ""

	print("Downloading files from github")
	for _, file in pairs(files) do
		print("Downloading " .. file)
		-- https://raw.githubusercontent.com/blueberrys/cc-blue-api/master/init.lua
		local url = "https://raw.githubusercontent.com/" .. username .. "/" .. repo .. "/" .. branch .. "/" .. file
		local resp = http.get(url)
		if resp then
			local data = resp.readAll()

			if data and data ~= "Not Found" then
				local f = fs.open(fs.combine(path, file), "w")
				f.write(data)
				f.close()
			end
			resp.close()
		end
	end
end

local function addFiles(filesToAdd)
	for _, addFile in pairs(filesToAdd) do
		local have = false
		for _, oldFile in pairs(minFiles) do
			if addFile == oldFile then
				have = true
				break
			end
		end
		if not have then
			table.insert(minFiles, addFile)
		end
	end
end

--

if custom then
	print("Using custom installation")
	addFiles(custom)
end

-- Install blue api
install(user, repo, "master", minFiles, dir)

-- Init blue api
shell.run(run)

-- Download all files
if not custom then
	-- Load b_git
	b_api.load("b_git")
	-- Use b_git to install rest of api
	b_git.install(user, repo, "master", dir, exclFiles)
	-- Re-init (new init.lua available)
	shell.run(run)
end
