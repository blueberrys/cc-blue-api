--[[
File mangement
]]

--[[
Usage

- write(path, data)
Writes data to file at path

- read(path)
Reads and returns data from file at path

- hasData(path, data)
Returns whether the file at path contains specific data

- createAppend(path, data)
Appends data to file, creates new if needed

- removeData(path, data)
Removes specific data from file

- trimLuaExtFile(file)
Removes .lua extension of a file
Useful for loading api's

- trimLuaExtDir(dir, recursive)
Removes .lua extension of all lua files in dir

]]

function write(path, data)
	local f = fs.open(path, "w")
	f.write(data)
	f.close()
end

function read(path)
	if not fs.exists(path) then
		return nil
	end
	local f = fs.open(path, "r")
	local data = f.readAll()
	f.close()
	return data
end

function hasData(path, data)
	local content = read(path)
	if (content and content:find(data, 1, true)) then
		return true
	end
	
	return false
end

function createAppend(path, data)
	if fs.exists(path) then
		local f = fs.open(path, "a")
		f.write(data)
		f.close()
	else
		write(path, data)
	end
end

function removeData(path, data)
	if fs.exists(path) then
		local content = read(path)
		local i, j = content and content:find(data, 1, true)
		if i then
			local newContent = content:sub(1, i-1) .. content:sub(j)
			write(path, newContent)
		end
	end
end

function trimLuaExtFile(file)
	if (file:sub(-4)==".lua") then
		local old_file = file:sub(1, file:len()-4)
		if fs.exists(old_file) then
			fs.delete(old_file)
		end
		fs.move(file, old_file)
	end
end

function trimLuaExtDir(dir, recurse)
	for _, fileName in pairs(fs.list(dir)) do
		local file = fs.combine(dir, fileName)

		if not fs.isDir(file) then
			trimLuaExtFile(file)
		elseif recurse then
			trimLuaExtDir(file, recurse)
		end
	end
end
