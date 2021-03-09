-->>Services and modules
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local config = require(script.Configuration)
local utils = require(script.Utilities)

-->>Initial setup tasks
local heartbeatWait = utils.heartbeatWait
local holder = utils.constructFromProperties("Folder", config.holder)

local module = {}

-->>(Function) [Yields] [Returns Nametag] addTag(player: Player)
--Creates a new default nametag for a specfied player and returns it.
module.addTag = function(player)
	-->>Creates the components separately using util and config.
	local billboard = utils.constructFromProperties("BillboardGui", config.billboard)
	local frame = utils.constructFromProperties("Frame", config.frame)
	local name = utils.constructFromProperties("TextLabel", config.name)
	local mainStat = utils.constructFromProperties("TextLabel", config.mainStat)
	local extraStat = utils.constructFromProperties("TextLabel", config.extraStat)
	local healthBar = utils.constructFromProperties("Frame", config.healthBar)
	local healthBackground = healthBar:Clone()

	-->>Sets up the individual components
	billboard.Enabled = false
	healthBackground.BackgroundTransparency = .5
	healthBackground.Name = "HealthBackground"
	healthBackground.ZIndex = 1
	if player ~= nil then
		local finalName = utils.waitForProperty(player, "Name")
		billboard.Name = finalName..config.billboard["Name"]
		if config.options["useDisplayName"] == true then
			if player.DisplayName ~= nil then --Deals with the gradual rollout of display names; some players don't have access yet.
				name.Text = player.DisplayName
			else
				name.Text = finalName
			end
			mainStat.Text = "@"..finalName
		else
			name.Text = finalName
		end
	else--Deals with blank tags. Warning prevents accidental use.
		billboard.Name = "BLANK_TAG--"..tostring(os.time())
		warn("Creating an empty tag is not recommended, aside from use with NPCs. Do not forget to delete unused tags.")
	end

	-->>Assembles the components into a nametag and puts it into the holder.
	name.Parent = frame
	mainStat.Parent = frame
	extraStat.Parent = frame
	healthBar.Parent = frame
	healthBackground.Parent = frame
	frame.Parent = billboard
	billboard.Parent = holder

	return billboard--Sends the tag back to the requester for use with linkTag.
end

-->>(Function) getTag(player: Player) [Yields] [Returns Nametag]
--Gets a player's nametag using configuration data.
module.getTag = function(player)
	-->>Finds the info from config about the naming scheme
	local location = config.holder["Parent"]
	local holder = location:FindFirstChild(config.holder["Name"])
	local suffix = config.billboard["Name"]

	-->>Looks for the tag, then if it is not found waits to see if a tag is being renamed while the player loads.
	if player.Name ~= nil then
		if holder:FindFirstChild(player.Name..suffix) ~= nil then
			return holder:FindFirstChild(player.Name..suffix)
		elseif holder:FindFirstChild(suffix) ~= nil then
			repeat
				heartbeatWait(.01)
			until holder:FindFirstChild(player.Name..suffix) ~= nil or holder:FindFirstChild(suffix) == nil
			if holder:FindFirstChild(player.Name..suffix) ~= nil then
				return holder:FindFirstChild(player.Name..suffix)
			end
		else
			error(player.Name.."'s tag could not be found in "..location.Name..". Please create a new tag first.")
		end
	else--As with before, when the player's name does not load, the module will wait for it to catch up before proceeding.
		local finalName = utils.waitForProperty(player, "Name")
		if holder:FindFirstChild(finalName..suffix) ~= nil then
			return holder:FindFirstChild(finalName..suffix)
		else
			error(player.Name.."'s tag was not found when performing getTag.")
		end
	end
end

-->>(Function) linkTag(player: Player, tag: Nametag, groupId: Integer)
--Links a specific tag to a player. Including a group id will make it so the group role replaces MainStat.
module.linkTag = function(player, tag, groupId)
	-->>Deals with updating the name's text border color with the team color.
	if config.options["nameOutlinedWithTeamColor"] == true then
		local updateTeamColor = function()
			local nameLabel = tag:FindFirstChild(config.frame["Name"]):FindFirstChild(config.name["Name"])
			if player.Neutral ~= true then
				nameLabel.TextStrokeColor3 = player.TeamColor.Color
				nameLabel.TextStrokeTransparency = 0
			else
				nameLabel.TextStrokeTransparency = 1
				nameLabel.TextStrokeColor3 = config.presets["colors"]["secondary"]
			end
		end
		updateTeamColor()--Updates the team color preemptively just in case.
		player:GetPropertyChangedSignal("Team"):Connect(updateTeamColor)
	end

	-->> Manages spawn based changes.
	player.CharacterAppearanceLoaded:Connect(function(character)
		-->>Updates the health bar size.
		local healthBar = tag.Frame.HealthBar
		healthBar.Size = config.healthBar["Size"]
		character.Humanoid:GetPropertyChangedSignal("Health"):Connect(function()
			tag.Frame.HealthBar.Size = UDim2.new((character.Humanoid.Health/character.Humanoid.MaxHealth) * config.options["healthBarScale"], healthBar.Size.X.Offset, healthBar.Size.Y.Scale, healthBar.Size.Y.Offset)
		end)
		-->>Updates the MainStat with the role.
		if groupId ~= nil then
			if config.options["useDisplayName"] == true then
				tag.Frame.ExtraStat.Text = player:GetRoleInGroup(groupId)
			else
				tag.Frame.MainStat.Text = player:GetRoleInGroup(groupId)
			end
		end
		-->>Changes the humanoid to display the tag.
		character.Humanoid.DisplayDistanceType = "None"
		tag.Adornee = character.Head
	end)
	tag.Enabled = true--Enables the tag to make it visible after the chanes are complete.
end

-->>(Function) changeTag(tag: Nametag, objectName: String [Specific], properties: Dictionary [Specific])
--Changes the properties of the specified object in a given player's nametag.
--Strings are names of objects, as specified in config.
--Dictionaries are in the format {Property = Value; Property = Value; etc.}. Example: {Text = "Spam"; ZIndex = 5}.
module.changeTag = function(tag, objectName, properties)
	--Uses util functions to modify the selected 
	if tag ~= nil then
		if objectName ~= "Frame" then
			utils.modifyFromProperties(tag.Frame:FindFirstChild(objectName), properties)
		else
			utils.modifyFromProperties(tag:FindFirstChild(objectName), properties)
		end
	else
		error("The function changeTag experienced an error: the tag passed to the function no longer exists. No changes have been made.")
	end
end

return module
