function write(path, data)
	local f = fs.open(path, "w")
	f.write(data)
	f.close()
end