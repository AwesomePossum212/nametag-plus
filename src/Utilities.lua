--!strict
--[[

    constructFromProperties(class, properties): Instance
    modifyFromProperties(object, properties): nil

--]]

local util = {}
local RunService = game:GetService("RunService")

-->> Functions
local function heartbeatWait()
	local startTime = os.clock()
	RunService.Heartbeat:Wait()
	return os.clock() - startTime
end

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

local function waitForProperty(object: Instance, propertyName: string)
	if object ~= nil then
		if object[propertyName] ~= nil then
			return object[propertyName]
		else
			coroutine.wrap(function()
				repeat
					heartbeatWait()
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
