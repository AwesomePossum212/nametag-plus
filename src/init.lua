--!strict
--[[

        NametagPlus.addTag(player): BillboardGui
        NametagPlus.getTag(player): BillboardGui
        NametagPlus.changeTag(tag, objectName, newPropertyValues): nil
        NametagPlus.linkTag(player, tag, groupId?): nil

--]]

local config = require(script.Configuration)
local utils = require(script.Utilities)

local holder = utils.constructFromProperties("Folder", config.defaults.holder)

local nametagPlus = {}

-->> Functions
local function addTag(player: Player): BillboardGui
	-- Create the essentials for the nametag
	-- Overriding the type is essential for typechecking.
	local billboard: BillboardGui = utils.constructFromProperties("BillboardGui", config.defaults.billboard)
	local frame: Frame = utils.constructFromProperties("Frame", config.defaults.frame)
	local name: TextLabel = utils.constructFromProperties("TextLabel", config.defaults.name)
	local mainStat: TextLabel = utils.constructFromProperties("TextLabel", config.defaults.mainStat)
	local extraStat: TextLabel = utils.constructFromProperties("TextLabel", config.defaults.extraStat)
	local healthBar: Frame = utils.constructFromProperties("Frame", config.defaults.healthBar)
	local healthBackground = healthBar:Clone()

	-- Initial setup of components
	billboard.Enabled = true
	healthBackground.BackgroundTransparency = 0.5
	healthBackground.Name = "HealthBackground"
	healthBackground.ZIndex = 1

	if player ~= nil then
		local finalName = utils.waitForProperty(player, "Name")
		billboard.Name = finalName .. config.defaults.billboard["Name"]

		if config.options["useDisplayName"] == true then
			if player.DisplayName ~= nil then
				name.Text = player.DisplayName
			else
				name.Text = finalName
			end
			mainStat.Text = "@" .. finalName
		else
			name.Text = finalName
		end
	else
		billboard.Name = "BLANK_TAG--" .. tostring(os.time())
		warn(
			"Creating an empty tag is not recommended,"
				.. "aside from use with NPCs."
				.. "Do not forget to delete unused tags."
		)
	end

	-- Final construction of components
	name.Parent = frame
	mainStat.Parent = frame
	extraStat.Parent = frame
	healthBar.Parent = frame
	healthBackground.Parent = frame
	billboard.Parent = holder

	return billboard
end

local function getTag(player: Player): BillboardGui
	-- Gets the current naming scheme
	local location = config.defaults.holder["Parent"]
	local shadow_holder = location:FindFirstChild(config.defaults.holder["Name"])
	local suffix = config.defaults.billboard["Name"]

	-- Looks for the tag, then if it is not found waits to see
	-- if a tag is being renamed while the player loads.
	if player.Name ~= nil then
		if shadow_holder:FindFirstChild(player.Name .. suffix) ~= nil then
			return shadow_holder:FindFirstChild(player.Name .. suffix)
		elseif shadow_holder:FindFirstChild(suffix) ~= nil then
			repeat
				task.wait(0.01)
			until shadow_holder:FindFirstChild(player.Name .. suffix) ~= nil
				or shadow_holder:FindFirstChild(suffix) == nil

			if shadow_holder:FindFirstChild(player.Name .. suffix) then
				return shadow_holder:FindFirstChild(player.Name .. suffix)
			end
		else
			error(player.Name .. "'s tag could not be found in " .. location.Name .. ". Please create a new tag first.")
		end
	else
		local finalName = utils.waitForProperty(player, "Name")
		if shadow_holder:FindFirstChild(finalName .. suffix) ~= nil then
			return shadow_holder:FindFirstChild(finalName .. suffix)
		else
			error(player.Name .. "'s tag was not found when performing getTag.")
		end
	end
end

local function changeTag(tag: BillboardGui, objectName: string, newPropertyValues: Dictionary<any>): nil
	-- Uses util functions to modify the selected
	if tag ~= nil then
		if objectName ~= "Frame" then
			local newObjWithProps = utils.modifyFromProperties(tag.Frame:FindFirstChild(objectName), newPropertyValues)
			tag.Frame = newObjWithProps
		else
			local newObjWithProps = utils.modifyFromProperties(tag:FindFirstChild(objectName), newPropertyValues)
			local oldObj = tag.Frame:FindFirstChild(objectName)
			oldObj = newObjWithProps
		end
	else
		error(
			"The function changeTag experienced an error: the tag passed to the function no longer exists. No changes have been made."
		)
	end
end

local function linkTag(player: Player, tag: BillboardGui, groupId: number | nil): nil
	-- Deals with updating the name's text border color with the team color.
	if config.options["nameOutlinedWithTeamColor"] == true then
		local updateTeamColor = function()
			local nameLabel: TextLabel = tag
				:FindFirstChild(config.defaults.frame["Name"])
				:FindFirstChild(config.defaults.name["Name"])
			if player.Neutral ~= true then
				nameLabel.TextStrokeColor3 = player.TeamColor.Color
				nameLabel.TextStrokeTransparency = 0
			else
				nameLabel.TextStrokeTransparency = 1
				nameLabel.TextStrokeColor3 = config.presets["colors"]["secondary"]
			end
		end
		updateTeamColor() -- Updates the team color preemptively just in case.
		player:GetPropertyChangedSignal("Team"):Connect(updateTeamColor)
	end

	--  Manages spawn based changes.
	player.CharacterAppearanceLoaded:Connect(function(character)
		-- Updates the health bar size.
		local healthBar: Frame = tag.Frame.HealthBar
		healthBar.Size = config.defaults.healthBar["Size"]
		character:WaitForChild("Humanoid"):GetPropertyChangedSignal("Health"):Connect(function()
			tag.Frame.HealthBar.Size = UDim2.new(
				(character.Humanoid.Health / character.Humanoid.MaxHealth) * config.options["healthBarScale"],
				healthBar.Size.X.Offset,
				healthBar.Size.Y.Scale,
				healthBar.Size.Y.Offset
			)
		end)
		-- Updates the MainStat with the role.
		if groupId ~= nil then
			if config.options["useDisplayName"] == true then
				tag.Frame.ExtraStat.Text = player:GetRoleInGroup(groupId)
			else
				tag.Frame.MainStat.Text = player:GetRoleInGroup(groupId)
			end
		end
		-- Changes the humanoid to display the tag.
		character.Humanoid.DisplayDistanceType = "None"
		tag.Adornee = character.Head
	end)
	tag.Enabled = true -- Enables the tag to make it visible after the changes are complete.
end

-->> Exports
nametagPlus.addTag = addTag
nametagPlus.getTag = getTag
nametagPlus.changeTag = changeTag
nametagPlus.linkTag = linkTag

return nametagPlus
