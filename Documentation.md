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
## ReplicatedStorage
- Roblox's [ReplicatedStorage](https://developer.roblox.com/en-us/api-reference/class/ReplicatedStorage) Service.
## ReplicatedFirst
- Roblox's [ReplicatedFirst](https://developer.roblox.com/en-us/api-reference/class/ReplicatedFirst) Service.
## TeleportService
- Roblox's [TeleportService](https://developer.roblox.com/en-us/api-reference/class/TeleportService) Service.
## CoreGui
- Roblox's [CoreGui](https://developer.roblox.com/en-us/api-reference/class/CoreGui) Service.
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
# Functions
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
<bool> TeamCheck -- Team Check (If the player is the same team as you, he gets skipped)
<bool> AliveCheck -- Alive Check (If the player is dead, he gets skipped)
<bool> WallCheck -- Wall Check (LAGGY, RECOMMENDED TO KEEP AT false) (If the player is obscured by parts / not visible, he gets skipped, this property is useful to add the element of appearing as legit)
```
- Returns the Player which is closest to your mouse cursor, parameters:
  - **Distance** - The radius of checking, if the player is not within this radius of your mouse, he gets skipped out of the checking circle. If left empty, set to `math.huge` by default.
  - **Part** - The part that the function runs all the checks for. If left empty, set to `"HumanoidRootPart"` by default.
  - **Settings** - If left empty, all values are set to `false` by deafult. 
## OnScreenCheck
```lua
<bool> OnScreenCheck(<userdata (Instance)> Object)
```
- Checks if the entered **Object** is visible on your [Viewport Screen Point](https://developer.roblox.com/en-us/api-reference/function/Camera/WorldToViewportPoint)
## TableDump
```lua
<void> TableDump(<table> Table)
```
- Dumps / prints a table with a cap of 9 stacks.
- This function is the same as this [function](https://github.com/Exunys/Table-Dump).
## Rejoin
```lua
<void> Rejoin(<void>)
```
- Rejoins the current server, useful refreshing most scripts.
## SetFOV
```lua
<void> SetFOV(<uint> FieldOfView)
```
- Sets the [Camera](https://developer.roblox.com/en-us/api-reference/class/Camera)'s **FieldOfView** property to the entered parameter.
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
# Extra
## ED_UnloadFunctions
```lua
<void> ED_UnloadFunctions(<void>)
```
- Short for *Exunys Developer Unload Functions*, unloads this library.