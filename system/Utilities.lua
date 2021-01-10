--Services and modules
local RunService = game:GetService("RunService")
-->>Some useful functions that take a table of properties.
local module = {}

-->>(Function) [Yields] [Returns time elapsed] heartbeatWait(length: Number)
--Uses Runservice.Heartbeat to wait a more exact amount of time
module.heartbeatWait = function(length)
	local startTime = os.clock()
	RunService.Heartbeat:Wait(length)
	return os.clock() - startTime
end

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

-->>(Function) modifyFromProperties(object: Instance, properties: Dictionary [Specific])
--Any instance works, but intended for certain UI components in the nametag.
--See NametagModule for properties table usage (changeTag).
module.modifyFromProperties = function(object, properties)
	for key, value in pairs(properties) do
		object[key] = value
	end
end

-->>(Function) [Yields] [Returns loaded property's value] waitForProperty(object:Instance, propertyName: String [Specific])
--Waits for a property to return a normal value, then sends it back to the requester.
module.waitForProperty = function(object, propertyName)
	if object ~= nil then
		if object[propertyName] ~= nil then--If we get lucky and the property is already loaded, send it back to the requester.
			return object[propertyName]
		else--But most of the time when this is called the property is yet to be loaded.
			coroutine.wrap(function()--A coroutine is used to let the requester move on without it being finished.
				repeat
					module.heartbeatWait(.01)
				until object[propertyName] ~= nil
				return object[propertyName]
			end)
		end
	end
end

return module