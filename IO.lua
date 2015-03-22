function pagedPrint(...)
	local str = ""
	for _, v in pairs(arg) do
		str = str .. v
	end
	textutils.pagedPrint(str)
end