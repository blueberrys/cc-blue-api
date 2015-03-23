--[[
Uses GitGet by apemanzilla
http://www.computercraft.info/forums2/index.php?/topic/17387-gitget-lightweight-github-downloader-now-with-preset-mode/
]]
local gg_id = "6aMMzdwd"
local gg_path = "gitget"
function install(username, repo, branch, path)
	if not fs.exists(gg_path) then
		shell.run("pastebin get ", gg_id, gg_path)
		print("Credits to apemanzilla")
	end

	if not branch then branch = "master" end
	shell.run(gg_path, username, repo, branch, path)
end