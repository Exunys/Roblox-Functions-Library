# Services
## RunService
- Roblox's [RunService](https://developer.roblox.com/en-us/api-reference/class/RunService) Service.
## UserInputService
- Roblox's [UserInputService](https://developer.roblox.com/en-us/api-reference/class/UserInputService) Service.
## HttpService
- Roblox's [HttpService](https://developer.roblox.com/en-us/api-reference/class/HttpService) Service.
## TweenService
- Roblox's [TweenService](https://developer.roblox.com/en-us/api-reference/class/TweenService) Service.
## StarterGui
- Roblox's [StarterGui](https://developer.roblox.com/en-us/api-reference/class/StarterGui) Service.
## Players
- Roblox's [Players](https://developer.roblox.com/en-us/api-reference/class/Players) Service.
## StarterPlayer
- Roblox's [StarterPlayer](https://developer.roblox.com/en-us/api-reference/class/StarterPlayer) Service.
## Lighting
- Roblox's [Lighting](https://developer.roblox.com/en-us/api-reference/class/Lighting) Service.
## ReplicatedStorage
- Roblox's [ReplicatedStorage](https://developer.roblox.com/en-us/api-reference/class/ReplicatedStorage) Service.
## ReplicatedFirst
- Roblox's [ReplicatedFirst](https://developer.roblox.com/en-us/api-reference/class/ReplicatedFirst) Service.
## TeleportService
- Roblox's [TeleportService](https://developer.roblox.com/en-us/api-reference/class/TeleportService) Service.
## CoreGui
- Roblox's [CoreGui](https://developer.roblox.com/en-us/api-reference/class/CoreGui) Service.
## VirtualUser
- Roblox's [VirtualUser](https://developer.roblox.com/en-us/api-reference/class/VirtualUser) Service.
## Camera
- Roblox's Workspace [Camera](https://developer.roblox.com/en-us/api-reference/class/Camera).
# Variables
## LocalPlayer
- Your [Client](https://developer.roblox.com/en-us/api-reference/property/Players/LocalPlayer), short for `Players.LocalPlayer`.
## Typing
- This variable tells if the user of the script is typing with their keyboard (meaning they have focused onto a textbox). Returns `true` if they have focused a textbox & are typing and vice versa.
- Example:
```lua
if Typing then
  print("Player is focused onto a textbox...")
end
```
## Mouse
- This variable stores the LocalPlayer's Mouse. Equivalent to `LocalPlayer:GetMouse()`.
# Functions
## GetService
```lua
<userdata> GetService(<string> Service)
```
- Safer alternative to **game.GetService**.
## Encode
```lua
<string> Encode(<table> Table)
```
- Encodes a Lua table into a JSON table and returns the string format of the JSON-Encoded table.
## Decode
```lua
<table> Decode(<string> JSON Table)
```
- Decodes a JSON string format table into a Lua table and returns it.
## SendNotification
```lua
<void> SendNotification(<string> Title, <string> Description, <uint> Duration, <string> Icon)
```
- Sends a notification using Roblox's [StarterGui](https://developer.roblox.com/en-us/api-reference/class/StarterGui) service.
- Preview:

![image](https://user-images.githubusercontent.com/76539058/162580732-f43bcdd8-1c2a-4a49-b1d2-726d7b4f8c2b.png)
## StringToRGB
```lua
<userdata (Color3)> StringToRGB(<string> Red, <string> Green, <string> Blue)
```
- Converts a string format of a RGB value to the a `Color3.fromRGB` value.
## RGBToString
```lua
<string> RGBToString(<userdata (Color3)> RGB)
```
- Converts a `Color3.fromRGB` value into a string.
## GetClosestPlayer
```lua
<userdata (Instance)> GetClosestPlayer(<uint> Distance from Mouse Cursor, <string> Part to check (example HumanoidRootPart), <table> Settings)
```
- Settings:
```lua
<bool> [1] TeamCheck -- Team Check (If the player is the same team as you, he gets skipped)
<bool> [2] AliveCheck -- Alive Check (If the player is dead, he gets skipped)
<bool> [3] WallCheck -- Wall Check (LAGGY, RECOMMENDED TO KEEP AT false) (If the player is obscured by parts / not visible, he gets skipped, this property is useful to add the element of appearing as legit)
```
- Returns the Player which is closest to your mouse cursor, parameters:
  - **Distance** - The radius of checking, if the player is not within this radius of your mouse, he gets skipped out of the checking circle. If left empty, set to `math.huge` by default.
  - **Part** - The part that the function runs all the checks for. If left empty, set to `"HumanoidRootPart"` by default.
  - **Settings** - If left empty, all values are set to `false` by deafult.
- Example:
```lua
GetClosestPlayer(90, "Head", {true, true, false})
```
## OnScreenCheck
```lua
<bool> OnScreenCheck(<userdata (Instance)> Object)
```
- Checks if the entered **Object** is visible on your [Viewport Screen Point](https://developer.roblox.com/en-us/api-reference/function/Camera/WorldToViewportPoint).
## Recursive
```lua
<void> Recursive(<table> Table, <function> Callback)
```
- Runs the given **Callback** function with the **index** of the **value** and the **value**.
- Example:
```lua
Recursive({1, {2, 3, {4}}}, print)
--[[ Output:
1 1
1 2
2 3
1 4
]]
```
## Rejoin
```lua
<void> Rejoin(<void>)
```
- Rejoins the current server, useful refreshing most scripts.
## ServerHop
```lua
<void> ServerHop(<uint/nil> Minimum Players, <uint/nil> Maximum Ping)
```
- Searches and joins a server in the game you are playing with the minimum player count of the parsed **Minimum Players** value or half of the universe's maximum player amount and maximum ping of the value of the **Maximum Ping** argument or 100. 
## SetFOV
```lua
<void> SetFOV(<uint> FieldOfView)
```
- Sets the [Camera](https://developer.roblox.com/en-us/api-reference/class/Camera)'s **FieldOfView** property to the entered parameter.
## SetStretch
```lua
<void> SetStretch(<uint> Stretch Amount)
```
- Stretches / distorts the screen amplified with the parsed parameter.
## SetMouseIconVisibility
```lua
<void> SetMouseIconVisibility(<bool> Value)
```
- This function makes your mouse cursor visible / invisible depending on the entered parameter (Value).
## GetPlayer
```lua
<userdata (Instance)> GetPlayer(<string> Short Player Name)
```
- This function returns the player with the most matching username to the entered value.
- This function checks regardless of capital/lowercase letters or how many characters entered. (It's recommended you input as much characters for the best accuracy)
## WallCheck
```lua
<bool> WallCheck(<userdata (Instance> Object, <table> Blacklist)
```
- Checks if the **Object** is obscured by walls, instances listed inside **Blacklist** will be ignored.
- If **Blacklist** parameter is *nil*, It's set to the descendants of the **Object** by default. 
## TeamCheck
```lua
<bool> TeamCheck(<userdata (Instance)> Player)
```
- If the entered **Player** object is in the same team as you, the function returns *true* and vice versa.
## AliveCheck
```lua
<bool> AliveCheck(<userdata (Instance)> Player)
```
- If the entered **Player** object is alive, the function returns *true* and vice versa.
## GetUniverseId
```lua
<uint> GetUniverseId()
```
- Returns the game's **Universe Identificator**, because Roblox doesn't display it in-game.
## GetIP
```lua
<string> GetIP()
```
- Returns the client's **IP Address**.
## GetHWID
```lua
<string> GetHWID()
```
- Returns the client's **Exploit Identifier** (not really the HWID but in this case it kind of acts like one).
## TestSpeed
```lua
<uint> TestSpeed(<function> Function, <uint> Checks)
```
- Test's the entered *Function*'s speed with the entered amount of *Checks*. If *Checks* are `nil` then *Checks* are set to `1000` by default.
- Examples:
```lua
loadstring(game:HttpGet("https://raw.githubusercontent.com/Exunys/Roblox-Functions-Library/main/Library.lua"))()

print(TestSpeed(function()
    local A, B, C = "A", "B", "C" 
end))

print(TestSpeed(function()
    local A, B, C = select(1, "A", "B", "C")
end))
```
![image_2022-05-03_212704232](https://user-images.githubusercontent.com/76539058/166548922-64246c01-dadf-44ea-9445-61e21085e76c.png)

# Extra
## ED_UnloadFunctions
```lua
<void> ED_UnloadFunctions()
```
- Short for *Exunys Developer Unload Functions*, unloads this library.
