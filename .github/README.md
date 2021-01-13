# Nametag+

### WARNING: Currently in beta!
Expect the possibility of major updates being released in the future. All releases going forward should be stable though.

### Background

Nametag+ (also referred to as NametagPlus) is designed to be a performant, modular, and accessible system for augmenting Roblox's built in name tags. This project was created based off of the core design principles from: https://devforum.roblox.com/t/open-source-fully-documented-nametag-and-rank-system/355445. Check the releases page for the lastest place file, which will have all of the code pre-assembled and contain example implementation.

### Usage Guide

Nametag+ is designed to simplify nametags into a few core functions. Note that you should always use module.func(par) as opposed to module:func(par)

**.addTag**(player: Player [optional]) [yields] [returns]

Constructs a new tag for the specified player (if no player is given then a blank tag will be made and a warning will be issued) in the style recorded in *Configuration*. Calling this function will cause the thread to yield until the *NametagModule* returns the nametag, but note that the nametag may not be named (and thus will be temporarily delay **getTag**) until the player's name is loaded. This is to maximize the speed of the return while still making sure each tag has a unique name.

**.getTag**(player: Player) [yields] [returns]

Gets the tag for a player that has already been created using data from *Configuration*. Because it uses a player's name, there may be a short yield while that loads in if this is called immediately after Roblox's .PlayerAdded event fires.

**.linkTag**(player: Player, tag: Nametag, groupId: Integer [specific])

Links a specific tag to a player, which makes it so the script automatically updates team color, group ranks, etc. The group id will make *NametagModule* automatically update a player's group role in the *MainStat* text label on spawn. This system allows you to link different players to different groups as needed. This should only be called once.

**.changeTag**(tag: Nametag, objectName: String [specific], properties: Dictionary [specific])

This will change the given part of the tag using the dictionary provided. The objectName parameter should be the name of the instance (in the nametag) that you want to change (i.e. "Frame" or "MainStat"). It is recommended to reference *Configuration* to get the most up-to-date name. The properties dictionary follows this format:

````
props = {
  propertyName = newValue;
  propertyName = newValue;
  *etc.*
}
````
So, for example:
````
example = {
  Text = "foo"
  ZIndex = 5
  Visible = true
}
````
### Example Implementation

A few notes to begin:
- *Configuration* and *Utilities* should be parented to *NametagModule*, and all should be module scripts.
- It is recommended that *NametagModule* be placed in ReplicatedStorage.

**Bare minimum**

````
local nametagSystem = require(game:GetService("ReplicatedStorage"):FindFirstChild("NametagModule")
game:GetService("Players").PlayerAdded:Connect(function(player)
  local tag = nametagSystem.addTag(player)
  nametagSystem.linkTag(player, tag)
end
````
This example, given the default setup, will create a new nametag for every player who joins. Note that there are no redundancies on the .PlayerAdded event, so some players may not get nametags (.PlayerAdded does not always fire).

**Group + Config**
````
-->>Services and modules
local nametagSystem = require(game:GetService("ReplicatedStorage"):FindFirstChild("NametagModule")
local nametagConfig = require(nametagSystem.Configuration)

-->>Constants and globals
local groupId = --Insert your group's id here or leave it blank

-->>Give new players a new tag.
game:GetService("Players").PlayerAdded:Connect(function(player)
  local tag = nametagSystem.addTag(player)
  nametagSystem.linkTag(player, tag, groupId)
end
````
This example will set the given player's MainStat to their role in the specified group on spawn (if no id is given then the group role will not be activated).

**Check releases for the latest stable interactive example set up.**

### Questions? Suggestions? Head over to Discussions!
