--[[
Widgets

Dependencies:
b_io
]]

--[[
Usage

- progress(total, amt, msg)
Send variables to the current progress_fn
Default prints a progress bar and msg using b_io.prnt

- setProgressFn(fn)
Sets fn as the new progress_fn

- getProgressFn()
Gets the current progress_fn

]]

if not b_api then
	print("Could not load dependencies")
	print("Run \"blu\" for automatic dependency management")
	return
end
b_api.depend({"b_io"})

--

local progress_fn = function(total, amt, msg)
	local prg = ""
	local prgAmt = 20/total*amt

	for i=1, prgAmt, 1 do
		prg = prg .. "="
	end

	b_io.prnt("[" .. prg .. "]")
	b_io.prnt(msg)
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
