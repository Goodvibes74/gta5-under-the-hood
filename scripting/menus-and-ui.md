# 03 Menus and UI

Menus are built with **LemonUI** (`scripts/LemonUI.SHVDN3.dll`, version 2.2.0). It draws the same menus the game uses (like the Interaction Menu), and handles keyboard, mouse and controller input for you.

> **Sources:** LemonUI members from the metadata and shipped XML docs of `LemonUI.SHVDN3.dll` 2.2.0. Notifications from `ScriptHookVDotNet3.dll` 3.7.0.189. iFruitAddon2 from the metadata of `iFruitAddon2.dll` 3.1.1. Every member named here was compile-checked (the [examples](/examples)). Details: Where everything comes from.

Full reference: [LemonUI](https://github.com/LemonUIbyLemon/LemonUI). Complete example: [`examples/04_LemonMenu.cs`](/examples/04_LemonMenu.cs).

## Building a menu with LemonUI

Four steps: a pool, a menu, items, and a way to open it.

```csharp
using LemonUI;
using LemonUI.Menus;

public class MyMod : Script
{
    private readonly ObjectPool pool = new ObjectPool();                      // 1. pool
    private readonly NativeMenu menu = new NativeMenu("My Mod", "Main menu"); // 2. menu

    public MyMod()
    {
        pool.Add(menu);

        var heal = new NativeItem("Heal", "Restores health.");               // 3. items
        heal.Activated += (sender, e) => Game.Player.Character.Health = Game.Player.Character.MaxHealth;
        menu.Add(heal);

        Tick += (sender, e) => pool.Process();                               // draw + input, every frame
        KeyDown += (sender, e) =>
        {
            if (e.KeyCode == Keys.Pause)                                       // 4. open and close
                menu.Visible = !menu.Visible;
        };
    }
}
```

Rules that trip people up:

- **Every menu goes in the pool,** submenus included, or it never draws.
- **Call `pool.Process()` every frame** in `Tick`.
- Items and their events can be created in the constructor. Game state (the player, vehicles) should be read when the event fires, not stored in the constructor.

## Item types

| Item | Looks like | Main members | Event |
| --- | --- | --- | --- |
| `NativeItem(title, description, altTitle)` | A line, with optional right-hand text | `Title`, `AltTitle`, `Description`, `Enabled`, `LeftBadge`, `RightBadge`, `Tag` | `Activated` (Enter / A / Cross) |
| `NativeCheckboxItem(title, description, check)` | A tickbox | `Checked` | `CheckboxChanged` |
| `NativeListItem<T>(title, description, values...)` | `< value >`, changed with left and right | `Items`, `SelectedItem`, `SelectedIndex`, `Add`, `Remove` | `ItemChanged` (`e.Object` is the new value) |
| `NativeSliderItem(title, description, max, value)` | A bar from 0 to `Maximum` | `Value`, `Maximum`, `Multiplier` | `ValueChanged` |
| `NativeDynamicItem<T>(title, description, item)` | Like a list, but you compute the next value | `SelectedItem` | `ItemChanged` |
| `NativeSeparatorItem(title)` | A divider line, can't be selected | | |
| `NativeSubmenuItem` | A line that opens another menu | `Menu` | Created by `menu.AddSubMenu(otherMenu)` |

Every item also has `Selected` (highlighted) and `Activated` events, and an `Enabled` flag (disabled items show greyed out).

## Menu members

| Member | What it does |
| --- | --- |
| `Visible` | Open or close |
| `Title`, `Subtitle`, `Description` | Texts. `Title` is the banner, `Subtitle` the bar under it |
| `Banner` | Replace the banner graphic (`ScaledTexture`, `ScaledRectangle`) |
| `Add(item)`, `Remove(item)`, `Clear()`, `Items` | Manage items |
| `AddSubMenu(menu)` | Adds a line that opens `menu`, and returns it as a `NativeSubmenuItem` |
| `SelectedItem`, `SelectedIndex` | The highlighted item |
| `MaxItems` | Items per page before scrolling (default 10) |
| `Width`, `Offset`, `Alignment` | Size and position |
| `UseMouse`, `RotateCamera` | Mouse control, and whether the camera turns while the menu is open |
| `Shown`, `Closed`, `Opening`, `Closing`, `SelectedIndexChanged`, `ItemActivated` | Events. `Opening` and `Closing` can be cancelled with `e.Cancel = true` |

Useful pool members: `pool.AreAnyVisible` (any of your menus open), `pool.HideAll()`, `pool.RefreshAll()` (after a resolution change).

## Opening a menu with a controller

LemonUI handles input inside the menu, but opening it is up to you. Check a button combo in `Tick`, only when the controller was the last device used, because frontend controls are also mapped to keyboard keys:

```csharp
using GTA.Input;

if (!pool.AreAnyVisible
    && Game.LastInputMethod == InputMethod.GamePad
    && Controls.IsControlPressed(ControlType.FrontendControl, ControlAction.FrontendRb)
    && Controls.IsControlJustPressed(ControlType.FrontendControl, ControlAction.FrontendDown))
{
    menu.Visible = true;
}
```

Pick a combo nobody else uses; check the other menu mods you have installed.

## Other LemonUI elements

| Namespace | Types | Use |
| --- | --- | --- |
| `LemonUI.Elements` | `ScaledText`, `ScaledRectangle`, `ScaledTexture`, `ScaledAnim` | Text, boxes and images positioned in a resolution-independent way |
| `LemonUI.TimerBars` | `TimerBarCollection`, `TimerBar`, `TimerBarProgress`, `TimerBarObjective` | The bars at the bottom right during missions (timers, scores, progress) |
| `LemonUI.Scaleform` | `BigMessage`, `BruteForce`, `Celebration`, `InstructionalButtons`, `LoadingScreen`, `PopUp`, ... | The game's full-screen effects: "WASTED"-style messages, the button hints at the bottom right |
| `LemonUI.Menus` | `NativeMenu` and items (above), `NativeGridPanel`, `NativeColorPanel`, `NativeStatsPanel` | Menus and the panels under a menu item |

Everything with a `Process()` method goes in the pool, the same as menus.

## Notifications, subtitles and help text (SHVDN)

| Want | Code |
| --- | --- |
| Feed message above the map | `Notification.PostTicker("text", false)` |
| Feed message with a picture and a title | `Notification.PostMessageText(...)` (see `Notification` in the SHVDN3 reference) |
| Subtitle | `Screen.ShowSubtitle("text", 2000)` |
| Help box at the top left | `Screen.ShowHelpText("text", 5000)` |
| Button icons inside text | `~INPUT_CONTEXT~` inside the string shows the player's key or button for that control |
| Colour inside text | `~r~` red, `~g~` green, `~b~` blue, `~y~` yellow, `~s~` back to normal, `~n~` new line |

## Phone contacts with iFruitAddon2

`scripts/iFruitAddon2.dll` (3.1.1) adds contacts to the in-game phone. It has no documentation of its own; its API is listed in [`../reference/iFruitAddon2/README.md`](https://github.com/Bob74/iFruitAddon2). Add a reference to it in your `.csproj`:

```xml
<ItemGroup>
  <Reference Include="iFruitAddon2">
    <HintPath>$(GameScriptsDir)iFruitAddon2.dll</HintPath>
    <Private>false</Private>
  </Reference>
</ItemGroup>
```

Then ([`examples/05_PhoneContact.cs`](/examples/05_PhoneContact.cs)):

```csharp
using iFruitAddon2;

private readonly CustomiFruit phone = new CustomiFruit();

// in the constructor:
var mechanic = new iFruitContact("Mechanic")
{
    DialTimeout = 3000,          // ms of ringing before it's answered
    Active = true,
    Icon = ContactIcon.Lester,   // the portrait. ContactIcon has one for most characters
};
mechanic.Answered += contact =>
{
    Notification.PostTicker("The mechanic is on his way.", false);
    phone.Close(2000);           // hang up after 2 s
};
phone.Contacts.Add(mechanic);
Tick += (sender, e) => phone.Update();   // every frame
```

`scripts/iFruitAddon2/config.ini` `StartIndex` sets where added contacts begin in the list.

## Legacy: NativeUI

Old mods use NativeUI (`UIMenu`, `MenuPool`, `UIMenuItem`) with SHVDN v2. Don't use it for new scripts. See [guide 07](/scripting/legacy-shvdn2.md).
