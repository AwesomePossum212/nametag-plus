local config = {}
config.defaults = {}

-- Basic settings used in the whole system.
config.options = {
	isHealthBarVisible = false;
	defaultText = "";
	maxDistanceVisibleFrom = 50;
	nameOutlinedWithTeamColor = true;
	healthBarAnchorPoint = Vector2.new(0, 0);
	healthBarScale = .8;
    --[[ Overrides the name
        name -> display name
        mainStat -> username
        extraStat -> group rank (if a group is linked)
        name and mainStat will keep the display/user name unless
        it is overrided with changeTag().
    --]]
	useDisplayName = false;
}

-- Preset styles
config.presets = {
	colors = {
		primary = Color3.new(1, 1, 1);
		secondary = Color3.new(0, 0, 0);
	};
	fonts = {
		primary = Enum.Font.GothamBlack;
		secondary = Enum.Font.Gotham;
	};
}
-- The rest of the script is the properties of UI components.
config.defaults.holder = {
	Name = "NametagFolder";
	Parent = game:GetService("Workspace");
}
config.defaults.billboard = {
	Name = "--Nametag";
	Active = true;
	AlwaysOnTop = false;
	LightInfluence = 0;
	MaxDistance = config.options["maxDistanceVisibleFrom"];
	ExtentsOffsetWorldSpace = Vector3.new(0, 5, 0);
	ResetOnSpawn = false;
	Size = UDim2.new(8, 0, 2, 0);
}
config.defaults.frame = {
	Name = "Frame";
	BackgroundTransparency = 1;
	BorderSizePixel = 0;
	BackgroundColor3 = config.presets["colors"]["secondary"];
	BorderColor3 = config.presets["colors"]["primary"];
	Size = UDim2.new(1, 0, 1, 0);
}
config.defaults.name = {
	Name = "PlayerName";
	BackgroundTransparency = 1;
	BorderSizePixel = 0;
	BackgroundColor3 = config.presets["colors"]["secondary"];
	BorderColor3 = config.presets["colors"]["primary"];
	Position = UDim2.new(0, 0, 0, 0);
	Size = UDim2.new(1, 0, .4, 0);
	TextColor3 = config.presets["colors"]["primary"];
	TextScaled = true;
	Text = config.options["defaultText"];
	Font = config.presets["fonts"]["primary"];
}
config.defaults.mainStat = {
	Name = "MainStat";
	BackgroundTransparency = 1;
	BorderSizePixel = 0;
	BackgroundColor3 = config.presets["colors"]["secondary"];
	BorderColor3 = config.presets["colors"]["primary"];
	Position = UDim2.new(0, 0, .4, 0);
	Size = UDim2.new(1, 0, .3, 0);
	TextColor3 = config.presets["colors"]["primary"];
	TextScaled = true;
	Text = config.options["defaultText"];
	Font = config.presets["fonts"]["secondary"];
	TextStrokeColor3 = config.presets["colors"]["secondary"];
}
config.defaults.extraStat = {
	Name = "ExtraStat";
	BackgroundTransparency = 1;
	BorderSizePixel = 0;
	BackgroundColor3 = config.presets["colors"]["secondary"];
	BorderColor3 = config.presets["colors"]["primary"];
	Position = UDim2.new(0, 0, .7, 0);
	Size = UDim2.new(1, 0, .2, 0);
	TextColor3 = config.presets["colors"]["primary"];
	TextScaled = true;
	Text = config.options["defaultText"];
	Font = config.presets["fonts"]["secondary"];
}
config.defaults.healthBar = {
	Name = "HealthBar";
	BackgroundTransparency = 0;
	BorderSizePixel = 0;
	BackgroundColor3 = config.presets["colors"]["primary"];
	BorderColor3 = config.presets["colors"]["primary"];
	Position = UDim2.new((1 - config.options["healthBarScale"])/2, 0, .925, 0);
	Size = UDim2.new(config.options["healthBarScale"], 0, .05, 0);
	Visible = config.options["isHealthBarVisible"];
	AnchorPoint = config.options["healthBarAnchorPoint"];
	ZIndex = 2;
}

return config
