# Nametag+

___Background___

Nametag+ (also referred to as NametagPlus) is designed to be a performant, modular, and accessible system for augmenting Roblox's built in name tags. This project was created based off of the core design principles from: https://devforum.roblox.com/t/open-source-fully-documented-nametag-and-rank-system/355445. Check the releases page for the lastest place file, which will have all of the code pre-assembled and contain example implementation.

___Usage Guide___

Nametag+ is designed to simplify nametags into a few core functions. Note that you should always use module.func(par) as opposed to module:func(par)

**.addTag**(player: Player [optional]) [yields] [returns]

Constructs a new tag for the specified player (if no player is given then a blank tag will be made and a warning will be issued) in the style recorded in *Configuration*. Calling this function will cause the thread to yield until the *NametagModule* returns the nametag, but note that the nametag may not be named (and thus will be temporarily delay **getTag**) until the player's name is loaded. This is to maximize the speed of the return while still making sure each tag has a unique name.

**.getTag**(player: Player) [yields] [returns]

Gets the tag for a player that has already been created using data from *Configuration*. Because it uses a player's name, there may be a short yield while that loads in if this is called immediately after Roblox's .PlayerAdded event fires.

**.linkTag**(player: Player, tag: Nametag, groupId: Integer [specific])

Links a specific tag to a player, which makes it so the script automatically updates team color, group ranks, etc. The group id will make *NametagModule* automatically update a player's group role in the *MainStat* text label on spawn. This should only be called once.

changeTag(tag: Nametag, objectName: String [specific], properties: Dictionary [specific])
