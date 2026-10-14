# 5. Your first C# mod

Write a script that heals you and shows a message when you press a key. First as a loose `.cs` file that SHVDN compiles for you (no tools beyond a text editor), then as a proper project built into a `.dll`. Part of the [modding path](README.md). The full API tour is [C# with SHVDN 3](/scripting/csharp-shvdn3.md); this page is the guided first hour.

## Short version

- A SHVDN script is a `public` class that extends `GTA.Script`. SHVDN creates one of each it finds in `scripts\*.cs` and `scripts\*.dll`.
- Hook `Tick` for per-frame code and `KeyDown` for keys, in the constructor.
- A loose `.cs` file can be reloaded in game: edit, then type `Reload()` in the F4 console.
- When it grows, move it to a project and build a `.dll` with the .NET SDK. Close the game before copying the new DLL.
- Exceptions don't crash the game: SHVDN shows them in the F4 console and `ScriptHookVDotNet.log`, and stops that script.

## Part 1: a loose `.cs` file (10 minutes)

### Pick a key

Choose a key no other installed mod uses. Check each mod's `.ini` and your trainer's settings. This page uses `Pause`; change it if that's taken.

### Write the script

Create `scripts\FirstMod.cs` in the game folder with this text:

```csharp
using System;
using System.Windows.Forms;   // Keys and KeyEventArgs
using GTA;                    // Script, Game, Ped
using GTA.UI;                 // Notification

public class FirstMod : Script
{
    public FirstMod()
    {
        // Runs once, when SHVDN loads the script. Only hook events here: the world may not exist yet.
        KeyDown += OnKeyDown;
    }

    private void OnKeyDown(object sender, KeyEventArgs e)
    {
        if (e.KeyCode != Keys.Pause)
            return;

        Ped me = Game.Player.Character;
        me.Health = me.MaxHealth;
        me.Armor = 100;
        Notification.PostTicker("Healed by my first mod", false);
    }
}
```

### Run it

1. Start the game in story mode (or, if it's running, press F4 and type `Reload()`).
2. Lose some health, press your key. You should see the notification and a full health bar.
3. Nothing? Press F4. A red error means a typo; it names the line. No error and no `FirstMod` in `ListScripts()` means the file isn't in `scripts` or the class isn't `public`.

### What each part does

| Line | Why |
| --- | --- |
| `public class FirstMod : Script` | SHVDN only loads public classes that extend `Script` |
| Constructor | Runs once. Hook events and read settings here; don't spawn or change the world |
| `KeyDown += OnKeyDown` | Your method now runs on every key press while the game has focus |
| `Game.Player.Character` | The player's ped (a wrapper around the `PLAYER_PED_ID` native) |
| `Notification.PostTicker` | The feed message above the minimap |

## Part 2: per-frame code (10 minutes)

Add a `Tick` handler that shows your speed while you drive. Add this to the constructor:

```csharp
        Tick += OnTick;
```

and this method to the class:

```csharp
    private void OnTick(object sender, EventArgs e)
    {
        // Runs every frame: keep it cheap. No file access, no searching every ped in the world.
        Vehicle car = Game.Player.Character.CurrentVehicle;
        if (car == null)
            return;                                   // on foot: CurrentVehicle is null

        float kmh = car.Speed * 3.6f;                 // Speed is metres per second
        GTA.UI.Screen.ShowSubtitle($"{kmh:0} km/h", 100); // must be shown again every frame
    }
```

Reload and drive. This shows the two rules from [step 1](01-how-mods-work.md#the-frame-loop-the-one-idea-that-matters-most): code in `Tick` runs every frame, and anything on screen must be drawn every frame.

(`GTA.UI.Screen` is written out in full because `System.Windows.Forms` also has a `Screen`; the [examples](/examples/01_HelloWorld.cs) use an alias for it instead.)

## Part 3: clean up after yourself

Anything you create or change, put back when the script stops. SHVDN raises `Aborted` on reload, on an exception, and at game exit:

```csharp
    // In the constructor: Aborted += OnAborted;
    private void OnAborted(object sender, EventArgs e)
    {
        // Delete spawned entities, remove blips, restore wanted level or traffic settings you changed.
    }
```

This first mod creates nothing, so the handler stays empty, but get used to writing it. Rockstar's own mission scripts have exactly this shape: every mission ends in one cleanup routine ([mission anatomy](/docs/gameplay/missions/mission-anatomy.md)).

## Part 4: a real project and a `.dll` (30 minutes)

Loose files are fine for experiments. For anything bigger (several files, a menu library, sharing it) build a DLL.

1. Install the .NET SDK (https://dotnet.microsoft.com/download).
2. Make a folder **outside** the game's `scripts` folder (SHVDN would try to compile every `.cs` in `scripts`), for example `Documents\GtaMods\FirstMod`.
3. Move `FirstMod.cs` there and add `FirstMod.csproj` next to it:

   ```xml
   <Project Sdk="Microsoft.NET.Sdk">
     <PropertyGroup>
       <TargetFramework>net48</TargetFramework>
       <LangVersion>latest</LangVersion>
       <!-- Change this to your game folder -->
       <GameDir>C:\Program Files (x86)\Steam\steamapps\common\Grand Theft Auto V</GameDir>
     </PropertyGroup>
     <ItemGroup>
       <!-- Lets the build find .NET Framework 4.8 without installing its targeting pack -->
       <PackageReference Include="Microsoft.NETFramework.ReferenceAssemblies" Version="1.0.3" PrivateAssets="all" />
       <Reference Include="System.Windows.Forms" />
       <Reference Include="System.Drawing" />
       <!-- Private=false: never copy or ship SHVDN's own DLL with your mod -->
       <Reference Include="ScriptHookVDotNet3">
         <HintPath>$(GameDir)\ScriptHookVDotNet3.dll</HintPath>
         <Private>false</Private>
       </Reference>
     </ItemGroup>
   </Project>
   ```

4. In that folder: `dotnet build -c Release`. The result is `bin\Release\net48\FirstMod.dll`.
5. **Close the game,** copy `FirstMod.dll` into `scripts`, start the game. Same behaviour as before, now from a DLL.

Why `net48`? SHVDN runs scripts on .NET Framework 4.8, not on modern .NET (**Known**). Visual Studio users can open the `.csproj` directly; to debug with breakpoints, see [C# with SHVDN 3, Debugging](/scripting/csharp-shvdn3.md#debugging).

## Exercises

1. Add an `.ini` setting for the key: `Settings.GetValue("Keys", "Heal", Keys.Pause)` reads `scripts\FirstMod.ini` ([example 06](/examples/06_SettingsAndText.cs)).
2. Make the key also fix your car if you're in one (`Vehicle.Repair()`).
3. Spawn a car in front of you on a second key, and delete it in `Aborted` ([example 02](/examples/02_PlayerAndWorld.cs) shows how to request a model and spawn).
4. Turn the key into a menu with three actions ([menus and UI](/scripting/menus-and-ui.md), [example 04](/examples/04_LemonMenu.cs)).
5. Call a native SHVDN doesn't wrap, with `Function.Call` ([natives](/scripting/natives.md), [example 03](/examples/03_Natives.cs)).

Next: [6. Your first Lua script](06-first-lua-script.md), [7. Your first C++ mod](07-first-asi-mod.md), or straight to [8. Debugging](08-debugging.md).
