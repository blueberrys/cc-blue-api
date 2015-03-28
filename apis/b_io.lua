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

- getPrintFn()
Gets the current print_fn


- progress(total, amt, msg)
Send variables to the current progress_fn
Default prints a progress bar and msg using print_fn

- setProgressFn(fn)
Sets fn as the new progress_fn

- getProgressFn()
Gets the current progress_fn


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

local progress_fn = function(total, amt, msg)
	local prg = ""
	local prgAmt = 20/total*amt

	for i=1, prgAmt, 1 do
		prg = prg .. "="
	end

	print_fn("[" .. prg .. "]")
	print_fn(msg)
end

function progress(total, amt, msg)
	progress_fn(total, amt, msg)
end

function setProgressFn(fn)
	progress_fn = fn
end

function getProgressFn()
	return progress_fn
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
