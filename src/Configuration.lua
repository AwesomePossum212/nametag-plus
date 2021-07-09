local module = {}

-->>Basic settings used in the whole system.
module.options = {
	isHealthBarVisible = false;
	defaultText = "";
	maxDistanceVisibleFrom = 50;
	nameOutlinedWithTeamColor = true;
	healthBarAnchorPoint = Vector2.new(0, 0);
	healthBarScale = .8;
	useDisplayName = false; --Overrides the name -> display name, mainStat -> username, and extraStat -> group rank (if a group is linked). name and mainStat will keep the display/user name unless it is overrided with changeTag().
}

-->>Preset styles
module.presets = {
	colors = {
		primary = Color3.new(1, 1, 1);
		secondary = Color3.new(0, 0, 0);
	};
	fonts = {
		primary = Enum.Font.GothamBlack;
		secondary = Enum.Font.Gotham;
	};
}
-->>The rest of the script is the properties of UI components.
module.holder = {
	Name = "NametagFolder";
	Parent = game:GetService("Workspace");
}

module.billboard = {
	Name = "--Nametag";
	Active = true;
	AlwaysOnTop = false;
	LightInfluence = 0;
	MaxDistance = module.options["maxDistanceVisibleFrom"];
	ExtentsOffsetWorldSpace = Vector3.new(0, 5, 0);
	ResetOnSpawn = false;
	Size = UDim2.new(8, 0, 2, 0);
}

module.frame = {
	Name = "Frame";
	BackgroundTransparency = 1;
	BorderSizePixel = 0;
	BackgroundColor3 = module.presets["colors"]["secondary"];
	BorderColor3 = module.presets["colors"]["primary"];
	Size = UDim2.new(1, 0, 1, 0);
}

module.name = {
	Name = "PlayerName";
	BackgroundTransparency = 1;
	BorderSizePixel = 0;
	BackgroundColor3 = module.presets["colors"]["secondary"];
	BorderColor3 = module.presets["colors"]["primary"];
	Position = UDim2.new(0, 0, 0, 0);
	Size = UDim2.new(1, 0, .4, 0);
	TextColor3 = module.presets["colors"]["primary"];
	TextScaled = true;
	Text = module.options["defaultText"];
	Font = module.presets["fonts"]["primary"];
}

module.mainStat = {
	Name = "MainStat";
	BackgroundTransparency = 1;
	BorderSizePixel = 0;
	BackgroundColor3 = module.presets["colors"]["secondary"];
	BorderColor3 = module.presets["colors"]["primary"];
	Position = UDim2.new(0, 0, .4, 0);
	Size = UDim2.new(1, 0, .3, 0);
	TextColor3 = module.presets["colors"]["primary"];
	TextScaled = true;
	Text = module.options["defaultText"];
	Font = module.presets["fonts"]["secondary"];
	TextStrokeColor3 = module.presets["colors"]["secondary"];
}

module.extraStat = {
	Name = "ExtraStat";
	BackgroundTransparency = 1;
	BorderSizePixel = 0;
	BackgroundColor3 = module.presets["colors"]["secondary"];
	BorderColor3 = module.presets["colors"]["primary"];
	Position = UDim2.new(0, 0, .7, 0);
	Size = UDim2.new(1, 0, .2, 0);
	TextColor3 = module.presets["colors"]["primary"];
	TextScaled = true;
	Text = module.options["defaultText"];
	Font = module.presets["fonts"]["secondary"];
}

module.healthBar = {
	Name = "HealthBar";
	BackgroundTransparency = 0;
	BorderSizePixel = 0;
	BackgroundColor3 = module.presets["colors"]["primary"];
	BorderColor3 = module.presets["colors"]["primary"];
	Position = UDim2.new((1 - module.options["healthBarScale"])/2, 0, .925, 0);
	Size = UDim2.new(module.options["healthBarScale"], 0, .05, 0);
	Visible = module.options["isHealthBarVisible"];
	AnchorPoint = module.options["healthBarAnchorPoint"];
	ZIndex = 2;
}

return module
