# 02 Scripting with ScriptHookVDotNet v3 (C#)

ScriptHookVDotNet (SHVDN) lets you write mods in C#. `ScriptHookVDotNet.asi` hosts .NET inside the game and loads every `.dll` and loose `.cs` file in `scripts/`. Your code uses the API in `ScriptHookVDotNet3.dll`.

Full reference: [ScriptHookVDotNet](https://github.com/scripthookvdotnet/scripthookvdotnet). Working examples: [`/examples`](/examples).

> **Sources:** API names from the metadata of `ScriptHookVDotNet3.dll` 3.7.0.189. Every member named in this guide was compile-checked against it. Console commands from `ScriptHookVDotNet.asi`. Settings from `ScriptHookVDotNet.ini`. Details: Where everything comes from.

## Your first script

A script is a class that extends `GTA.Script`. SHVDN creates one instance of every such class it finds ([`examples/01_HelloWorld.cs`](/examples/01_HelloWorld.cs)):

```csharp
using GTA;
using GTA.UI;
using System;
using System.Windows.Forms;
using Screen = GTA.UI.Screen; // System.Windows.Forms has a Screen class too

public class HelloWorld : Script
{
    public HelloWorld()
    {
        Tick += OnTick;       // every frame
        KeyDown += OnKeyDown; // every key press
    }

    private void OnTick(object sender, EventArgs e)
    {
        if (Game.Player.Character.IsInVehicle())
            Screen.ShowSubtitle("You're driving", 100);
    }

    private void OnKeyDown(object sender, KeyEventArgs e)
    {
        if (e.KeyCode == Keys.Pause)
            Notification.PostTicker("Hello", false);
    }
}
```

### The script lifecycle

| Member of `Script` | When it runs | Use it for |
| --- | --- | --- |
| Constructor | Once, when the script loads (game start, or `Reload()` in the F4 console) | Hooking events, loading settings, building menus. Don't spawn things here: the world may not be loaded yet |
| `Tick` event | Every frame (or every `Interval` ms) | Your main logic. Keep it fast |
| `KeyDown` / `KeyUp` events | When a keyboard key goes down or up | Keyboard shortcuts. `e.KeyCode` is a `System.Windows.Forms.Keys` value |
| `Aborted` event | When the script stops (reload, error, game exit) | Deleting what you spawned, restoring changed settings |
| `Interval` property | Set it in the constructor | Milliseconds between `Tick` calls. `0` = every frame |
| `Script.Wait(ms)` | Call inside `Tick` | Pause *your* script while the game keeps running. Only inside `Tick` |
| `Script.Yield()` | Call inside `Tick` | Same as `Wait` for one frame |
| `BaseDirectory` | Any time | The `scripts` folder path, for loading your files |
| `Settings` | Any time | `scripts/<YourDllName>.ini`, loaded for you |
| `Abort()`, `Pause()`, `Resume()` | Any time | Stop or pause this script |

If your `Tick` throws an exception, SHVDN logs it to `ScriptHookVDotNet.log` and aborts the script. The game keeps running.

## The namespaces

| Namespace | What's in it | Main types |
| --- | --- | --- |
| `GTA` | The game world | `Game`, `World`, `Player`, `Ped`, `Vehicle`, `Prop`, `Entity`, `Model`, `Blip`, `Camera`, `GameplayCamera`, `Weapon`, `TaskInvoker`, `Wanted`, `Audio`, `ScriptSettings`, `Checkpoint`, `ParticleEffect`, `Rope`, `Scaleform`, `Pickup`, `PedGroup`, `RelationshipGroup`, `Interior`, `PathFind`, `ShapeTest` |
| `GTA.UI` | On-screen elements | `Notification`, `Screen`, `Hud`, `TextElement`, `Sprite`, `CustomSprite`, `ContainerElement`, `LoadingPrompt` |
| `GTA.Native` | Calling natives directly | `Function`, `Hash`, `InputArgument`, `OutputArgument`, `GlobalVariable` |
| `GTA.Math` | Maths | `Vector3`, `Vector2`, `Quaternion`, `Matrix` |
| `GTA.Input` | Game controls | `Controls` (`IsControlPressed`, `DisableControlThisFrame`, ...) |
| `GTA.Chrono` | In-game clock | `GameClock`, `GameClockTime`, `GameClockDate` |
| `GTA.NaturalMotion` | Euphoria ragdoll behaviours | `Euphoria` and its helpers (`ped.Euphoria.ShotHelper`, ...) |
| `GTA.Graphics` | Texture dictionaries | `Txd`, `TextureAsset` |

Enums such as `PedHash`, `VehicleHash`, `WeaponHash`, `Control`, `BlipSprite`, `BlipColor`, `Weather`, `VehicleSeat` give names to the game's numbers. Their values are listed in the reference.

## The player, peds, vehicles and the world

Examples from [`examples/02_PlayerAndWorld.cs`](/examples/02_PlayerAndWorld.cs).

### The player

```csharp
Player player = Game.Player;        // the player (controls, money, wanted level)
Ped me = Game.Player.Character;     // the player's body in the world

me.Health = me.MaxHealth;
me.Armor = 100;
me.Weapons.Give(WeaponHash.CarbineRifle, 250, true, true);
bool driving = me.IsInVehicle();
Vehicle car = me.CurrentVehicle;    // null when on foot

player.Wanted.SetWantedLevel(0, false);
player.Wanted.ApplyWantedLevelChangeNow(false);
```

`Player.WantedLevel` still works but is obsolete in 3.7: use `Player.Wanted` as above.

### Spawning

```csharp
Model model = new Model("adder");             // or VehicleHash.Adder, or an add-on model name
if (model.IsInCdImage && model.IsVehicle)
{
    model.Request(1000);                       // load the model, waiting up to 1 s
    Vector3 pos = me.GetOffsetPosition(new Vector3(0f, 5f, 0f)); // 5 m in front of the player
    Vehicle car = Vehicle.Create(model, pos, me.Heading);
    model.MarkAsNoLongerNeeded();              // let the game unload the model again
    car.PlaceOnGround();
}

Ped ped = Ped.Create(new Model(PedHash.Hipster01AMY), pos);
Prop prop = Prop.Create(new Model("prop_bench_01a"), pos, true, true); // dynamic, place on ground
```

`World.CreateVehicle`, `World.CreatePed`, `World.CreateProp`, `World.CreateBlip` and `World.CreateCheckpoint` also work but are obsolete in 3.7: use `Vehicle.Create`, `Ped.Create`, `Prop.Create`, `Blip.Create` and `Checkpoint.Create`.

**Clean up what you create.** Spawned entities stay forever. In `Aborted`, call `entity.Delete()` for things that should vanish, or `entity.MarkAsNoLongerNeeded()` to hand them back to the game.

### Entities (peds, vehicles and props share these)

| Member | What it does |
| --- | --- |
| `Position`, `Rotation`, `Heading` | Where it is and which way it faces |
| `Velocity`, `Speed` | Movement. `Speed` is in metres per second (multiply by 3.6 for km/h) |
| `Health`, `MaxHealth`, `IsDead`, `IsAlive` | Health |
| `IsInvincible`, `IsVisible`, `IsCollisionEnabled`, `IsPositionFrozen` | Toggles |
| `Exists()` | False once the game deleted it. Check before using an entity you stored |
| `GetOffsetPosition(Vector3)` | A point relative to the entity (x right, y forward, z up) |
| `AddBlip()` | A map marker that follows it |
| `AttachTo(...)`, `Detach()` | Attach to another entity |
| `Delete()`, `MarkAsNoLongerNeeded()` | Clean up |

### Peds

| Member | What it does |
| --- | --- |
| `Task` | Orders: `ped.Task.FightAgainst(target)`, `Wander()`, `EnterVehicle(car)`, `DriveTo(...)`, `FleeFrom(...)`, `ClearAllImmediately()`. See `TaskInvoker` in the reference |
| `Weapons` | `Give`, `Remove`, `Current`, `Select` |
| `IsInVehicle()`, `CurrentVehicle`, `SetIntoVehicle(car, seat)` | Vehicles |
| `RelationshipGroup` | Who they like and hate |
| `BlockPermanentEvents` | `true` = only follows your tasks, ignores gunfire and enemies |
| `Euphoria` | Ragdoll behaviours |
| `Style` | Clothes and props |

### Vehicles

| Member | What it does |
| --- | --- |
| `Mods` | Paint (`PrimaryColor`, `SecondaryColor`), upgrades, neon, plate text |
| `Doors`, `Windows`, `Wheels`, `Extras` | Collections of parts |
| `Repair()`, `Explode()` | Fix or destroy |
| `EngineHealth`, `BodyHealth`, `IsEngineRunning`, `IsSirenActive` | State |
| `Driver`, `GetPedOnSeat(VehicleSeat)` | Occupants |
| `HandlingData` | Handling values |

### The world and the game

| Member | What it does |
| --- | --- |
| `World.GetNearbyPeds(ped, radius)`, `GetNearbyVehicles`, `GetNearbyProps` | Find things around a point or ped |
| `World.GetAllPeds()`, `GetAllVehicles()` | Everything loaded |
| `World.WaypointPosition`, `Game.IsWaypointActive` | The map waypoint |
| `World.Weather`, `GameClock` | Weather and time |
| `World.GetGroundHeight(pos, out float z)` | Ground height, if the area is loaded |
| `World.Raycast(...)`, `ShapeTest` | What's between two points |
| `World.AddExplosion(...)`, `Blip.Create(pos)`, `Checkpoint.Create(...)` | Effects and markers |
| `Game.GameTime`, `Game.FPS`, `Game.TimeScale` | Timing and slow motion |
| `Controls.IsControlPressed(ControlType.PlayerControl, ControlAction.Jump)` | A game control, keyboard or controller (`GTA.Input`). The older `Game.IsControlPressed(Control.Jump)` still works but is obsolete |
| `Game.IsKeyPressed(Keys)` | A keyboard key right now |
| `Game.LastInputMethod` | `InputMethod.GamePad` or `MouseAndKeyboard` |

## Input: keys and controller

- **Keyboard shortcut:** `KeyDown` event and `e.KeyCode`.
- **Controller (and keyboard) game actions:** check `Controls.IsControlJustPressed(ControlType.FrontendControl, ControlAction.FrontendAccept)` in `Tick` (`using GTA.Input;`). Controls are actions, not buttons: `FrontendAccept` is A / Cross on a controller and Enter on a keyboard. `ControlType.PlayerControl` is for on-foot and driving actions, `FrontendControl` for menu actions. The `ControlAction` values are the GTA control IDs (`Jump` = 22, `FrontendAccept` = 201). The older `Game.IsControlJustPressed(Control.X)` still works but is obsolete in 3.7.
- **Stop the game reacting to a button while your mod uses it:** call `Controls.DisableControlActionThisFrame(ControlType.PlayerControl, ControlAction.Jump)` every frame.
- **Never hard-code a key.** Read it from your ini, and default to `None`, so it can't clash with another mod.

## Settings files

```csharp
ScriptSettings settings = ScriptSettings.Load(Path.Combine(BaseDirectory, "MyMod.ini"));
Keys key = settings.GetValue("Keys", "MenuKey", Keys.None);   // section, key, default
bool show = settings.GetValue("Display", "ShowSpeed", false);
settings.SetValue("Display", "ShowSpeed", true);
settings.Save();                                               // writes it back
```

Works with strings, numbers, bools and enums. Full sample: [`examples/06_SettingsAndText.cs`](/examples/06_SettingsAndText.cs).

## Drawing on screen

| Need | Use |
| --- | --- |
| Pop-up above the map | `Notification.PostTicker("text", false)` |
| Subtitle at the bottom | `Screen.ShowSubtitle("text", 2000)` |
| Help box at the top left | `Screen.ShowHelpText("text", 5000)` |
| Your own text | `new TextElement("text", new PointF(x, y), scale)`, then `.Draw()` **every frame** in `Tick` |
| Rectangles, images | `ContainerElement`, `Sprite`, `CustomSprite` |
| Fade the screen | `Screen.FadeOut(ms)`, `Screen.FadeIn(ms)` |
| Menus | LemonUI, see [guide 03](/scripting/menus-and-ui.md) |

Screen positions in `GTA.UI` use a 1280 x 720 canvas, whatever the real resolution.

## Natives from C#

When SHVDN has no property for something, call the native:

```csharp
using GTA.Native;
Function.Call(Hash.SET_PED_CAN_RAGDOLL, Game.Player.Character, false);
int time = Function.Call<int>(Hash.GET_GAME_TIMER);
```

Details, output parameters and finding natives: [guide 05](/scripting/natives.md).

## Debugging

| Tool | How |
| --- | --- |
| SHVDN console | **F4** in game. Shows exceptions as they happen. Commands are listed below |
| Log | `ScriptHookVDotNet.log` in the game folder: each script loading, and every exception with its stack trace |
| Your own log | `File.AppendAllText(Path.Combine(BaseDirectory, "MyMod.log"), text + Environment.NewLine)` |
| Breakpoints | Visual Studio: Debug > Attach to Process > `GTA5.exe`, code type "Managed (.NET Framework 4.x)". |
| Quick on-screen values | `Screen.ShowSubtitle(value.ToString(), 100)` inside `Tick` |

### Console commands

Press **F4**, type a command with its brackets, press Enter. String arguments go in double quotes. Read from the runtime's own metadata ([SHVDN-Runtime reference](https://github.com/scripthookvdotnet/scripthookvdotnet)):

| Command | What it does |
| --- | --- |
| `Help()` | Print the default help |
| `Help("Reload")` | Help for one command |
| `Clear()` | Clear the console |
| `Reload()` | Reload all scripts from `scripts/` (picks up rebuilt `.cs` files and changed settings; a rebuilt `.dll` can't be copied while the game runs) |
| `ListScripts()` | List every loaded script |
| `Start("MyMod.dll")` | Load the scripts in one file |
| `StartAllScripts()` | Load every script in `scripts/` |
| `Abort("MyMod.dll")` | Stop the scripts from one file |
| `AbortAll()` | Stop every running script |

### SHVDN settings that matter while developing

`ScriptHookVDotNet.ini` in the game folder:

| Key | Current | Why you'd change it |
| --- | --- | --- |
| `ConsoleKeyBinding` | `F4` | The console key |
| `ReloadKeyBinding` | `None` | Set a free key to reload scripts with one press instead of typing `Reload()` |
| `ScriptTimeoutThreshold` | `5000` | Milliseconds a script may block before SHVDN aborts it. If your script gets aborted for "hanging", your `Tick` is too slow; fix that rather than raising this |
| `AutoLoadScripts` | `true` | `false` loads nothing at start, so you can start scripts one by one with `Start(...)` to find which one crashes |

### Common mistakes

| Symptom | Cause |
| --- | --- |
| Script never loads | Class isn't `public`, doesn't extend `Script`, or the DLL targets the wrong framework. Check the log |
| Game stutters | Heavy work in `Tick` every frame (`World.GetAllPeds()`, file access). Do it every N ms with `Interval` or a timer |
| `NullReferenceException` | `CurrentVehicle` is null on foot, or an entity was deleted. Check `!= null` and `Exists()` |
| Spawned thing doesn't appear | Model not loaded: call `model.Request(1000)` and check `model.IsLoaded` |
| Text flickers or vanishes | Drawn only once. Draw it every frame |
| Key does nothing | Another mod uses it, or the menu of another mod has focus. Check every installed mod's key settings |
| Rebuilt DLL isn't used | The game was running, so the copy into `scripts/` failed. Close the game and build again |

## Next

Menus: [guide 03](/scripting/menus-and-ui.md). Natives: [guide 05](/scripting/natives.md).
