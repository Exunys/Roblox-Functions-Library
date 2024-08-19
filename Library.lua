local cloneref = cloneref or function(...)
	return ...
end

local GetService = function(Service)
	return cloneref(game.GetService(game, Service))
end

--// Services

local Services = {
	RunService = GetService("RunService"),
	UserInputService = GetService("UserInputService"),
	HttpService = GetService("HttpService"),
	TweenService = GetService("TweenService"),
	StarterGui = GetService("StarterGui"),
	Players = GetService("Players"),
	StarterPlayer = GetService("StarterPlayer"),
	Lighting = GetService("Lighting"),
	ReplicatedStorage = GetService("ReplicatedStorage"),
	ReplicatedFirst = GetService("ReplicatedFirst"),
	TeleportService = GetService("TeleportService"),
	CoreGui = GetService("CoreGui"),
	VirtualUser = GetService("VirtualUser"),
	Camera = workspace.CurrentCamera
}

--// Variables

local Variables = {
	LocalPlayer = Services.Players.LocalPlayer,
	Typing = false,
	Mouse = Services.Players.LocalPlayer:GetMouse()
}

--// Functions

local Functions = {
	GetService = clonefunction and clonefunction(GetService) or GetService,
	
	Encode = function(Table)
		return Table and type(Table) == "table" and Services.HttpService:JSONEncode(Table)
	end,

	Decode = function(String)
		return String and type(String) == "string" and Services.HttpService:JSONDecode(String)
	end,

	SendNotification = function(TitleArg, DescriptionArg, DurationArg, IconArg)
		Services.StarterGui:SetCore("SendNotification", {
			Title = TitleArg,
			Text = DescriptionArg,
			Duration = DurationArg,
			Icon = IconArg
		})
	end,

	StringToRGB = function(String)
		if not String then return end
		
		local R = tonumber(string.match(String, "([%d]+)[%s]*,[%s]*[%d]+[%s]*,[%s]*[%d]+"))
		local G = tonumber(string.match(String, "[%d]+[%s]*,[%s]*([%d]+)[%s]*,[%s]*[%d]+"))
		local B = tonumber(string.match(String, "[%d]+[%s]*,[%s]*[%d]+[%s]*,[%s]*([%d]+)"))

		return Color3.fromRGB(R, G, B)
	end,

	RGBToString = function(RGB)
		return tostring(math.floor(RGB.R * 255))..", "..tostring(math.floor(RGB.G * 255))..", "..tostring(math.floor(RGB.B * 255))
	end,

	GetClosestPlayer = function(RequiredDistance, Part, Settings)
		RequiredDistance = RequiredDistance or 1 / 0
		Part = Part or "HumanoidRootPart"
		Settings = Settings or {false, false, false}

		local Target = nil

		for _, Value in next, Services.Players:GetPlayers() do
			if Value ~= Variables.LocalPlayer and Value.Character[Part] then
				if type(Settings) == "table" then
					if Settings[1] and Value.TeamColor == Variables.LocalPlayer.TeamColor then continue end
					if Settings[2] and Value.Character.Humanoid.Health <= 0 then continue end
					if Settings[3] and #(Services.Camera:GetPartsObscuringTarget({Value.Character[Part].Position}, Value.Character:GetDescendants())) > 0 then continue end
				end

				local Vector, OnScreen = Services.Camera:WorldToViewportPoint(Value.Character[Part].Position)
				local Distance = (Services.UserInputService:GetMouseLocation() - Vector2.new(Vector.X, Vector.Y)).Magnitude

				if Distance < RequiredDistance and OnScreen then
					RequiredDistance, Target = Distance, Value
				end
			end
		end

		return Target
	end,

	OnScreenCheck = function(Object)
		return Object.Position and select(2, Services.Camera:WorldToViewportPoint(Object.Position))
	end,

	Recursive = function(Table, Callback)
		for Index, Value in next, Table do
			Callback(Index, Value)

			if type(Value) == "table" then
				Recursive(Value, Callback)
			end
		end
	end,

	Rejoin = function()
		Services.TeleportService:Teleport(game.PlaceId, Variables.LocalPlayer)
	end,

	ServerHop = function(MinPlayers, MaxPing)
		for _, Value in next, Services.HttpService:JSONDecode(game:HttpGet(string.format("https://games.roblox.com/v1/games/%s/servers/Public?sortOrder=Asc&limit=100", game.PlaceId))) do
			if Value.playing ~= Value.maxPlayers and Value.playing and Value.playing > MinPlayers or Value.maxPlayers / 2 and Value.ping < MaxPing or 100 then
				Services.TeleportService:TeleportToPlaceInstance(game.PlaceId, Value.id, Variables.LocalPlayer)
			else
				warn("Exunys Developer - ROBLOX Functions & Services Reference Library > Server Hop - Couldn't find a server to hop to! Consider using the \"Rejoin\" option.")
			end
		end
	end,

	SetFOV = function(FOV)
		Services.Camera.FieldOfView = FOV
	end,

	SetStretch = function(Amount)
		Services.Camera.CFrame *= CFrame.new(0, 0, 0, 1, 0, 0, 0, Amount, 0, 0, 0, 1)
	end,

	SetMouseIconVisibility = function(Value)
		Services.UserInputService.MouseIconEnabled = Value
	end,

	GetPlayer = function(String)
		for _, Value in next, Services.Players:GetPlayers() do
			if string.sub(string.lower(Value.Name), 1, -1) == string.lower(String) then
				return Value
			end
		end
	end,

	WallCheck = function(Object, Blacklist)
		return #(Services.Camera:GetPartsObscuringTarget({Object}, type(Blacklist) == "table" and Blacklist or Object:GetDescendants())) > 0
	end,

	TeamCheck = function(Player)
		return Player.TeamColor == Variables.LocalPlayer.TeamColor
	end,

	AliveCheck = function(Player)
		return Player.Character:FindFirstChildOfClass("Humanoid").Health > 0
	end,

	GetUniverseId = function()
		return Services.HttpService:JSONDecode(game:HttpGetAsync("https://api.roblox.com/universes/get-universe-containing-place?placeid="..game.PlaceId)).UniverseId
	end,

	GetIP = function()
		return game:HttpGetAsync("https://api.ipify.org")
	end,

	GetHWID = function()
		local Data = Services.HttpService:JSONDecode(syn.request({Url = "https://httpbin.org/get"; Method = "GET"}).Body)

		for _, Value in next, {"Exploit-Guid", "Syn-Fingerprint", "Proto-User-Identifier", "Sentinel-Fingerprint", "SW-Fingerprint", "krnl-hwid"} do
			if not Data.headers[Value] then continue end

			return Data.headers[Value]
		end
	end,

	TestSpeed = function(Function, Checks)
		Checks = Checks or 1000

		local Start = tick()

		for _ = 1, Checks do
			Function()
		end

		return tick() - Start
	end
}

--// Main

for Index, Value in next, Services do
	getfenv(1)[Index] = Value
end

for Index, Value in next, Variables do
	getfenv(1)[Index] = Value
end

for Index, Value in next, Functions do
	getfenv(1)[Index] = Value
end

--// Managing

Services.UserInputService.TextBoxFocused:Connect(function()
	getfenv(1).Typing = true
end)

Services.UserInputService.TextBoxFocusReleased:Connect(function()
	getfenv(1).Typing = false
end)

--// Unload Function

getfenv(1).ED_UnloadFunctions = function()
	for Index, _ in next, Services do
		getfenv(1)[Index] = nil
	end

	for Index, _ in next, Variables do
		getfenv(1)[Index] = nil
	end

	for Index, _ in next, Functions do
		getfenv(1)[Index] = nil
	end
end
