-->>Some useful functions that take a table of properties.
local module = {}

-->>(Function) [Yields] [Returns Instance of specified class] constructFromProperties(class: String [Specific], properties: Dictionary [Specific])
--String should be a class name that can be constructed using Instance.new.
--See NametagModule for properties table usage (changeTag).
module.constructFromProperties = function(class, properties)
	local object = Instance.new(class)
	for key, value in pairs(properties) do
		object[key] = value
	end
	return object
end

-->>(Function)  modifyFromProperties(object: Instance, properties: Dictionary [Specific])
--Any instance works, but intended for certain UI components in the nametag.
--See NametagModule for properties table usage (changeTag).
module.modifyFromProperties = function(object, properties)
	for key, value in pairs(properties) do
		object[key] = value
	end
end

return module
