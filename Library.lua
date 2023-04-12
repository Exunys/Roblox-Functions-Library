--// Services

local Services = {
	RunService = game:GetService("RunService"),
	UserInputService = game:GetService("UserInputService"),
	HttpService = game:GetService("HttpService"),
	TweenService = game:GetService("TweenService"),
	StarterGui = game:GetService("StarterGui"),
	Players = game:GetService("Players"),
	StarterPlayer = game:GetService("StarterPlayer"),
	Lighting = game:GetService("Lighting"),
	ReplicatedStorage = game:GetService("ReplicatedStorage"),
	ReplicatedFirst = game:GetService("ReplicatedFirst"),
	TeleportService = game:GetService("TeleportService"),
	CoreGui = game:GetService("CoreGui"),
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

		for _, v in next, Services.Players:GetPlayers() do
			if v ~= Variables.LocalPlayer and v.Character[Part] then
				if type(Settings) == "table" then
					if Settings[1] and v.TeamColor == Variables.LocalPlayer.TeamColor then continue end
					if Settings[2] and v.Character.Humanoid.Health <= 0 then continue end
					if Settings[3] and #(Services.Camera:GetPartsObscuringTarget({v.Character[Part].Position}, v.Character:GetDescendants())) > 0 then continue end
				end

				local Vector, OnScreen = Services.Camera:WorldToViewportPoint(v.Character[Part].Position)
				local Distance = (Services.UserInputService:GetMouseLocation() - Vector2.new(Vector.X, Vector.Y)).Magnitude

				if Distance < RequiredDistance and OnScreen then
					RequiredDistance, Target = Distance, v
				end
			end
		end

		return Target
	end,

	OnScreenCheck = function(Object)
		return Object.Position and select(2, Services.Camera:WorldToViewportPoint(Object.Position))
	end,

	Recursive = function(Table, Callback)
		for i, v in next, Table do
			Callback(i, v)

			if type(v) == "table" then
				Recursive(v, Callback)
			end
		end
	end,

	Rejoin = function()
		Services.TeleportService:Teleport(game.PlaceId, Variables.LocalPlayer)
	end,

	SetFOV = function(FOV)
		Services.Camera.FieldOfView = FOV
	end,

	SetMouseIconVisibility = function(Value)
		Services.UserInputService.MouseIconEnabled = Value
	end,

	GetPlayer = function(String)
		for _, v in next, Services.Players:GetPlayers() do
			if string.sub(string.lower(v.Name), 1, -1) == string.lower(String) then
				return v
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

		for _, v in next, {"Exploit-Guid", "Syn-Fingerprint", "Proto-User-Identifier", "Sentinel-Fingerprint", "SW-Fingerprint", "krnl-hwid"} do
			if not Data.headers[v] then continue end

			return Data.headers[v]
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

for i, v in next, Services do
	getfenv(1)[i] = v
end

for i, v in next, Variables do
	getfenv(1)[i] = v
end

for i, v in next, Functions do
	getfenv(1)[i] = v
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
	for i, _ in next, Services do
		getfenv(1)[i] = nil
	end

	for i, _ in next, Variables do
		getfenv(1)[i] = nil
	end

	for i, _ in next, Functions do
		getfenv(1)[i] = nil
	end
end
