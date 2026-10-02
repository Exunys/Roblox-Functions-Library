# Roblox Scripting Library Documentation

A comprehensive documentation file for services, global variables, API functions, and extra utilities.

---

## Table of Contents
- [Services](#services)
- [Variables](#variables)
- [Functions](#functions)
- [Extra](#extra)

---

## Services

Quick references to commonly utilized Roblox Engine services:

* **[RunService](https://developer.roblox.com/en-us/api-reference/class/RunService)** — Manages time-related task management and frame updates.
* **[UserInputService](https://developer.roblox.com/en-us/api-reference/class/UserInputService)** — Detects and monitors user input events (keyboard, mouse, touch, gamepad).
* **[HttpService](https://developer.roblox.com/en-us/api-reference/class/HttpService)** — Handles JSON encoding/decoding and HTTP requests.
* **[TweenService](https://developer.roblox.com/en-us/api-reference/class/TweenService)** — Interpolates properties of instances smoothly over time.
* **[StarterGui](https://developer.roblox.com/en-us/api-reference/class/StarterGui)** — Manages interface templates and system notifications.
* **[Players](https://developer.roblox.com/en-us/api-reference/class/Players)** — Contains player objects and connection/disconnection events.
* **[StarterPlayer](https://developer.roblox.com/en-us/api-reference/class/StarterPlayer)** — Defines default settings and starter scripts for players.
* **[Lighting](https://developer.roblox.com/en-us/api-reference/class/Lighting)** — Controls world ambient lighting and atmosphere effects.
* **[ReplicatedStorage](https://developer.roblox.com/en-us/api-reference/class/ReplicatedStorage)** — Network-replicated storage accessible to both client and server.
* **[ReplicatedFirst](https://developer.roblox.com/en-us/api-reference/class/ReplicatedFirst)** — Container for client scripts that run as early as possible during loading.
* **[TeleportService](https://developer.roblox.com/en-us/api-reference/class/TeleportService)** — Handles client teleportation between places and servers.
* **[CoreGui](https://developer.roblox.com/en-us/api-reference/class/CoreGui)** — Contains internal Roblox user interface elements.
* **[VirtualUser](https://developer.roblox.com/en-us/api-reference/class/VirtualUser)** — Simulates real user inputs programmatically.
* **[Camera](https://developer.roblox.com/en-us/api-reference/class/Camera)** — Represents the client's current workspace view point.

---

## Variables

### `LocalPlayer`
* **Type:** `Player`
* **Description:** Represents the client player instance. Equivalent to `Players.LocalPlayer`.

### `Typing`
* **Type:** `boolean`
* **Description:** Indicates whether the local user is currently typing inside a focused text input box. Returns `true` if focused, `false` otherwise.
* **Example:**
  ```lua
  if Typing then
      print("Player is focused onto a textbox...")
  end
  ```

### `Mouse`
* **Type:** `Mouse`
* **Description:** Stores the local player's Mouse object. Equivalent to `LocalPlayer:GetMouse()`.

---

## Functions

### `GetService`
```lua
<userdata> GetService(<string> Service)
```
A safer alternative to `game:GetService()`.

---

### `Encode`
```lua
<string> Encode(<table> Table)
```
Encodes a Lua table into a JSON-formatted string and returns the result.

---

### `Decode`
```lua
<table> Decode(<string> JSONTable)
```
Decodes a JSON-formatted string back into a Lua table structure.

---

### `SendNotification`
```lua
<void> SendNotification(<string> Title, <string> Description, <uint> Duration, <string> Icon)
```
Sends a client-side notification popup using Roblox's [StarterGui](https://developer.roblox.com/en-us/api-reference/class/StarterGui) service.

**Preview:**

![Notification Preview](https://user-images.githubusercontent.com/76539058/162580732-f43bcdd8-1c2a-4a49-b1d2-726d7b4f8c2b.png)

---

### `StringToRGB`
```lua
<userdata (Color3)> StringToRGB(<string> Red, <string> Green, <string> Blue)
```
Converts string arguments representing RGB channel values into a `Color3.fromRGB` object.

---

### `RGBToString`
```lua
<string> RGBToString(<userdata (Color3)> RGB)
```
Converts a `Color3.fromRGB` object back into a formatted string.

---

### `GetClosestPlayer`
```lua
<userdata (Instance)> GetClosestPlayer(<uint> Distance, <string> Part, <table> Settings)
```
Finds and returns the player closest to the local player's mouse cursor within a designated radius.

* **Parameters:**
  * `Distance`: Search radius around the mouse cursor. Defaults to `math.huge` if unassigned.
  * `Part`: Target body part checked for distance (e.g., `"HumanoidRootPart"`). Defaults to `"HumanoidRootPart"`.
  * `Settings`: An optional array table containing boolean configurations `{TeamCheck, AliveCheck, WallCheck}`. Defaults to `{false, false, false}`.
    ```lua
    {
        [1] = TeamCheck,  -- <bool> Ignores players on your team
        [2] = AliveCheck, -- <bool> Ignores dead players
        [3] = WallCheck   -- <bool> Checks line-of-sight visibility (performance intensive)
    }
    ```

* **Example:**
  ```lua
  GetClosestPlayer(90, "Head", {true, true, false})
  ```

---

### `OnScreenCheck`
```lua
<bool> OnScreenCheck(<userdata (Instance)> Object)
```
Checks if the target `Object` is visible within the player's [Viewport Screen Point](https://developer.roblox.com/en-us/api-reference/function/Camera/WorldToViewportPoint).

---

### `Recursive`
```lua
<void> Recursive(<table> Table, <function> Callback)
```
Iterates recursively through nested table structures and executes the specified `Callback` function passing `index` and `value`.

* **Example:**
  ```lua
  Recursive({1, {2, 3, {4}}}, print)
  -- Output:
  -- 1 1
  -- 1 2
  -- 2 3
  -- 1 4
  ```

---

### `Rejoin`
```lua
<void> Rejoin()
```
Rejoins the current game server. Useful for re-initializing scripts or resetting state.

---

### `ServerHop`
```lua
<void> ServerHop(<uint/nil> MinPlayers, <uint/nil> MaxPing)
```
Finds and connects to a new server in the same game universe matching criteria.
* `MinPlayers`: Defaults to half of the game's maximum capacity if omitted.
* `MaxPing`: Defaults to `100` if omitted.

---

### `SetFOV`
```lua
<void> SetFOV(<uint> FieldOfView)
```
Updates the active [Camera](https://developer.roblox.com/en-us/api-reference/class/Camera)'s `FieldOfView` property to the specified value.

---

### `SetStretch`
```lua
<void> SetStretch(<uint> StretchAmount)
```
Applies screen stretching/distortion based on the provided intensity parameter.

---

### `SetMouseIconVisibility`
```lua
<void> SetMouseIconVisibility(<bool> Value)
```
Toggles the visual visibility of the mouse cursor (`true` for visible, `false` for hidden).

---

### `GetPlayer`
```lua
<userdata (Instance)> GetPlayer(<string> ShortName)
```
Searches for and returns a player instance matching a string query. Case-insensitive and supports partial matching.

---

### `WallCheck`
```lua
<bool> WallCheck(<userdata (Instance)> Object, <table> Blacklist)
```
Checks whether line-of-sight to an object is obstructed by physical geometry.
* `Blacklist`: Optional table of instances ignored during raycasting. Defaults to descendants of the target object if `nil`.

---

### `TeamCheck`
```lua
<bool> TeamCheck(<userdata (Instance)> Player)
```
Returns `true` if the specified target `Player` belongs to the same team as the local player.

---

### `AliveCheck`
```lua
<bool> AliveCheck(<userdata (Instance)> Player)
```
Returns `true` if the specified target `Player` is alive (Humanoid Health > 0).

---

### `GetUniverseId`
```lua
<uint> GetUniverseId()
```
Retrieves and returns the game's internal **Universe ID**.

---

### `GetIP`
```lua
<string> GetIP()
```
Returns the local client's public IP address.

---

### `GetHWID`
```lua
<string> GetHWID()
```
Returns the unique hardware execution identifier for the current client environment.

---

### `TestSpeed`
```lua
<uint> TestSpeed(<function> Function, <uint> Checks)
```
Measures and returns execution time for a given function across a specified iteration count (`Checks` defaults to `1000`).

* **Example:**
  ```lua
  loadstring(game:HttpGet("https://raw.githubusercontent.com/Exunys/Roblox-Functions-Library/main/Library.lua"))()

  print(TestSpeed(function()
      local A, B, C = "A", "B", "C" 
  end))

  print(TestSpeed(function()
      local A, B, C = select(1, "A", "B", "C")
  end))
  ```

**Benchmark Result:**

![Speed Test Result](https://user-images.githubusercontent.com/76539058/166548922-64246c01-dadf-44ea-9445-61e21085e76c.png)

---

## Extra

### `ED_UnloadFunctions`
```lua
<void> ED_UnloadFunctions()
```
Unloads the **Exunys Developer** library from memory and cleans up active references.
