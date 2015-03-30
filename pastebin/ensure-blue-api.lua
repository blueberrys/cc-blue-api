--[[
Ensure BlueAPI
Version 1.4

Installs BlueAPI and components if needed
Loads requested components automatically
]]

--[[
Usage:

pastebin run xQfeXVgj [apis..]

Apis should be names of additional api's to load
If given, they will be checked, and if not found, downloaded and loaded
If blank, full api will be downloaded depending on the version

Essential api's are loaded regardless, but can be included:
b_api
b_files
b_git
b_http
b_io
b_update

]]

local blueApiId = "yy7gqfBQ"
local blueApiDir = "blue-api"
local blueApiRun = fs.combine(blueApiDir, "init")

local blueVersionUrl = "https://raw.github.com/blueberrys/cc-blue-api/master/version"
local blueVersionFile = fs.combine(blueApiDir, "version")

-- For checking updates
local minimalApis = {
	"b_files",
	"b_git",
	"b_http",
	"b_io",
	"b_update",
}

--

-- Check if minimal BlueAPI is available
local function minimalCheck()
	if not b_api then
		if fs.exists(blueApiRun) then
			shell.run(blueApiRun)
		end
		if not b_api then
			return false
		end
	end

	for _, api in pairs(minimalApis) do
		if not b_api.load(api) then
			return false
		end
	end

	return true
end

-- Check if should get new version
local function checkNewVersion()
	if not minimalCheck() then
		return true
	else
		return b_update.checkUpdate(blueVersionUrl, blueVersionFile)
	end
end

-- Install api with params
local function installBlueApi(params)
	print("Installing blue-api (by Blueberrys)")
	shell.run("pastebin run", blueApiId, params)
	return b_api
end

-- Installs BlueAPI and components if needed
local function ensureBlueAPI(apis)
	local function loadApis()
		for _, api in pairs(apis) do
			b_api.load(api)
		end
	end

	-- Convert api's to list of params
	local params = ""
	for _, api in pairs(apis) do
		params = params .. " apis/" .. api .. ".lua"
	end
	params = params:sub(2)

	local should_install = false

	if params=="" then
		-- No params, new version available
		should_install = checkNewVersion()
	elseif not minimalCheck() then
		-- Essentials are missing
		should_install = true
	else
		-- Otherwise, check specifics
		-- b_api and minimal api's must be available now

		-- Check if all required api's exist
		for _, api in pairs(apis) do
			print("Checking ", api)
			-- Isn't loaded, can't load, probably doesn't exist
			if not _G[api] and not b_api.load(api) then
				should_install = true
				break
			end
		end
	end -- essentials

	if should_install then
		-- Install
		if not installBlueApi(params) then
			print("Error installing BlueAPI")
			return
		end
	end

	-- load all
	loadApis()
end

local params = {...}
ensureBlueAPI(params)
