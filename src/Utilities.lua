--[[

    constructFromProperties(class, properties): Instance
    modifyFromProperties(object, properties): nil
    waitForProperty(object, propertyName): property

--]]

local util = {}

-->> Functions
local function constructFromProperties(class: string, properties: Dictionary<any>)
	local object = Instance.new(class)

	for key, value in pairs(properties) do
		object[key] = value
	end

	return object
end

local function modifyFromProperties(object: Instance, properties: Dictionary<any>)
	local cObject = object:Clone()
	for key, value in pairs(properties) do
		cObject[key] = value
	end

	return cObject
end

local function waitForProperty(object: Instance, propertyName: string)
	if object ~= nil then
		if object[propertyName] then
			return object[propertyName]
		else
			coroutine.wrap(function()
				repeat
					task.wait(0.01)
				until object[propertyName] ~= nil

				return object[propertyName]
			end)
		end
	end
end

-- Exports
util.constructFromProperties = constructFromProperties
util.modifyFromProperties = modifyFromProperties
util.waitForProperty = waitForProperty

return util
