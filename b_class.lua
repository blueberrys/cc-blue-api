-- Incomplete, do not use
-- In progress..

local Class = {}

function new(baseClass, fn)
	if not baseClass then
		baseClass = Class
	end
	
	self = {}
	setmetatable(self, {__index=baseClass})
	setmetatable(self, {__call=new})
	return self
end