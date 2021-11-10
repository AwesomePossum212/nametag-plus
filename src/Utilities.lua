--!strict
--[[

    constructFromProperties(class, properties): Instance
    modifyFromProperties(object, properties): nil

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
	for key, value in pairs(properties) do
		object[key] = value
	end
end

-- Exports
util.constructFromProperties = constructFromProperties
util.modifyFromProperties = modifyFromProperties

return util
