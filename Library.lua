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
    Camera = game:GetService("Workspace").CurrentCamera
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
        if Table and type(Table) == "table" then
            return Services.HttpService:JSONEncode(Table)
        end
    end,

    Decode = function(String)
        if String and type(String) == "string" then
            return Services.HttpService:JSONDecode(String)
        end
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
        local R = tonumber(string.match(String, "([%d]+)[%s]*,[%s]*[%d]+[%s]*,[%s]*[%d]+"))
        local G = tonumber(string.match(String, "[%d]+[%s]*,[%s]*([%d]+)[%s]*,[%s]*[%d]+"))
        local B = tonumber(string.match(String, "[%d]+[%s]*,[%s]*[%d]+[%s]*,[%s]*([%d]+)"))

        return Color3.fromRGB(R, G, B)
    end,

    RGBToString = function(RGB)
        return tostring(math.floor(RGB.R * 255))..", "..tostring(math.floor(RGB.G * 255))..", "..tostring(math.floor(RGB.B * 255))
    end,

    GetClosestPlayer = function(RequiredDistance, Part, Settings)
        if not RequiredDistance then RequiredDistance = math.huge end
        if not Part then Part = "HumanoidRootPart" end
        if not Settings then Settings = {false, false, false} end

        local Target = nil

        for _, v in next, Services.Players:GetPlayers() do
            if v ~= Variables.LocalPlayer then
                if v.Character[Part] then
                    if type(Settings) == "table" then
                        if Settings[1] and v.TeamColor == Variables.LocalPlayer.TeamColor then continue end
                        if Settings[2] and v.Character.Humanoid.Health <= 0 then continue end
                        if Settings[3] and #(Services.Camera:GetPartsObscuringTarget({v.Character[Part].Position}, v.Character:GetDescendants())) > 0 then continue end
                    end

                    local Vector, OnScreen = Services.Camera:WorldToViewportPoint(v.Character[Part].Position)
                    local Distance = (Vector2.new(Services.UserInputService:GetMouseLocation().X, Services.UserInputService:GetMouseLocation().Y) - Vector2.new(Vector.X, Vector.Y)).Magnitude

                    if Distance < RequiredDistance and OnScreen then
                        RequiredDistance = Distance
                        Target = v
                    end
                end
            end
        end

        return Target
    end,

    OnScreenCheck = function(Object)
        if Object.Position then
            local _, OnScreen = Services.Camera:WorldToViewportPoint(Object.Position)

            return OnScreen
        else
            return nil
        end
    end,

    TableDump = function(Table)
        loadstring(game:HttpGet("https://raw.githubusercontent.com/Exunys/Table-Dump/main/Module.lua"))()(Table)
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
            if string.sub(string.lower(v.Name), 1, string.len(String)) == string.lower(String) then
                return v
            end
        end
    end,

    WallCheck = function(Object, Blacklist)
        if type(Blacklist) ~= "table" then Blacklist = Object:GetDescendants() end

        return #(Services.Camera:GetPartsObscuringTarget({Object}, Blacklist)) > 0
    end,

    TeamCheck = function(Player)
        if Player ~= Variables.LocalPlayer then
            return Player.TeamColor == Variables.LocalPlayer.TeamColor
        else
            return nil
        end
    end,

    AliveCheck = function(Player)
        if Player ~= Variables.LocalPlayer then
            return Player.Character.Humanoid.Health > 0
        else
            return nil
        end
    end,

    GetUniverseId = function()
        return Services.HttpService:JSONDecode(game:HttpGet("https://api.roblox.com/universes/get-universe-containing-place?placeid="..game.PlaceId)).UniverseId
    end,

    GetIP = function()
        return game:HttpGet("https://api.ipify.org")
    end,

    GetHWID = function()
        local Data = Services.HttpService:JSONDecode(syn.request({Url = "https://httpbin.org/get"; Method = "GET"}).Body)

        for _, v in next, {"Syn-Fingerprint", "Exploit-Guid", "Proto-User-Identifier", "Sentinel-Fingerprint"} do
            if Data.headers[v] then
                return Data.headers[v]
            end
        end

        return nil
    end,

    TestSpeed = function(Function, Checks)
        if not Checks then Checks = 1000 end

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
