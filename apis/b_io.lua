--[[
Input/Output
]]

--[[
Usage

- prnt(...)
Send variables to the current print_fn
Defaults to print

- setPrintFn(fn)
Sets fn as the new print_fn

- argToStr(...)
Converts arguments to string

- tblToArgStr(table)
Converts table to argument string

- pagedPrint(...)
Sends arguments to textutils.pagedPrint as a string
seperated by spaces

]]

local print_fn = print

function prnt(...)
	print_fn(...)
end

function setPrintFn(fn)
	print_fn = fn
end

function getPrintFn()
	return print_fn
end

--

function argToStr(sep, ...)
	local str = ""
	for _, a in pairs(arg) do
		str = str .. sep .. a
	end
	return str:sub(2)
end

function tblToArgStr(table)
	local str = ""
	for _, v in pairs(table) do
		str = str .. " " .. v
	end
	return str:sub(2)
end
