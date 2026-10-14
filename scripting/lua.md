# 06 The Lua plugin (LUA.asi)

`LUA.asi` is the "Lua Plugin for Script Hook V" by Headscript (version 1.0.0.1, May 2015). It runs Lua scripts with no compiling: edit a `.lua` file, restart the game, done. It's the quickest way to try something, but it's old: no updates since 2015, old native names, and no error console.

Reference: every native it can call, with today's name: `../reference/Lua-Natives.md`.

> **Sources:** plugin functions and native names from the strings inside `LUA.asi` 1.0.0.1 (no disassembly). Script structure from `scripts/main.lua`, `utils.lua`, `keys.lua`, `addins/basemodule.lua`. GUI library from `scripts/libs/GUI.lua` and `addins/exampleGUI.lua`, read in full. How output parameters and vectors are passed is inferred from how `GUI.lua` uses them, not confirmed. Details: Where everything comes from.

## What the plugin gives you

Found by reading the names compiled into `LUA.asi`:

| Thing | What it is |
| --- | --- |
| **Lua 5.2** | The language, with its standard libraries: `string`, `table`, `math`, `io`, `os`, `coroutine`, `debug`, `bit32`, `package` (`require`) |
| `lfs` | LuaFileSystem: `lfs.dir(path)` lists a folder (used by `main.lua` to find addins), plus `lfs.attributes`, `lfs.mkdir`, `lfs.currentdir`, ... |
| `get_key_pressed(vk)` | `true` while the keyboard key with that virtual-key code is down. Codes are named in `scripts/keys.lua` (`Keys.F5`, `Keys.NumPad8`, ...) |
| `wait(ms)` | Pause the script and let the game run |
| `PLAYER`, `PED`, `VEHICLE`, ... (41 tables) | The natives, called as `NAMESPACE.NAME(args)`. 4,824 of them, with **2015 names** |
| `init()` (you write it) | Called once after `scripts/main.lua` loads |
| `tick()` (you write it) | Called every frame |

`scripts/main.lua` defines `unload()` too, but the plugin never references that name, so it is probably never called.

## How a typical Lua mod setup is organised

```text
scripts/main.lua      entry point. The plugin runs it, then calls init() once and tick() every frame
scripts/keys.lua      Keys.* virtual-key codes for get_key_pressed()
scripts/utils.lua     small helpers (table.filter)
scripts/libs/*.lua    libraries, loaded first into the Libs table (GUI.lua = the menu library)
scripts/addins/*.lua  your features. Each is loaded with require and gets init() once and tick() every frame
```

`main.lua`'s `init()` loads every file in `libs/`, then every file in `addins/`. Its `tick()` calls each addin's `tick`. So you never edit `main.lua`: you add a file to `scripts/addins/`.

## Writing an addin

Copy `scripts/addins/basemodule.lua` to `scripts/addins/mymod.lua`:

```lua
local mymod = {}

local Keys = Keys          -- from keys.lua
local wasDown = false

function mymod.init()
    -- runs once when the addin loads
end

function mymod.tick()
    -- runs every frame: keep it fast
    local down = get_key_pressed(Keys.Pause)      -- pick a key no other mod uses
    if down and not wasDown then                  -- only on the frame the key goes down
        local player = PLAYER.PLAYER_PED_ID()
        ENTITY.SET_ENTITY_HEALTH(player, 200)
    end
    wasDown = down
end

function mymod.unload()
end

return mymod
```

Restart the game to load it. Return `false` instead of the table to disable an addin without deleting it.

## Calling natives

```lua
local player = PLAYER.PLAYER_PED_ID()
local inCar  = PED.IS_PED_IN_ANY_VEHICLE(player, false)
local hash   = GAMEPLAY.GET_HASH_KEY("adder")          -- GAMEPLAY is today's MISC
local w, h   = GRAPHICS.GET_SCREEN_RESOLUTION(0, 0)    -- see "Output parameters"
```

- **Old names.** `GAMEPLAY` (now `MISC`), `UI` (now `HUD`), `CONTROLS` (now `PAD`), `AI` (now `TASK`), `TIME` (now `CLOCK`). Look any native up in `Lua-Natives.md`: the "Current name" column links to its description.
- **Output parameters.** Where a native takes a pointer (`int*`, `float*`), pass a placeholder value and read the result as an extra return value. That's why `GET_SCREEN_RESOLUTION(0, 0)` returns `w, h`.
- **Vectors.** Natives returning a `Vector3` give back an object. Read its `x`, `y`, `z` fields (the plugin's Vector3 type has those fields, plus padding). Test once in game, because this is from reading the binary, not from documentation.
- **Booleans** come back as `true` / `false`, and you can pass `true` / `false` for `BOOL` parameters.
- **Missing natives.** Anything added to the game after 2015 isn't available, and some natives have changed since. If a call misbehaves, check its current description.

## Drawing text

```lua
UI.SET_TEXT_FONT(0)
UI.SET_TEXT_SCALE(0.0, 0.4)
UI.SET_TEXT_COLOUR(255, 255, 255, 255)
UI._SET_TEXT_ENTRY("STRING")
UI._ADD_TEXT_COMPONENT_STRING("Hello")
UI._DRAW_TEXT(0.5, 0.5)          -- x, y from 0.0 to 1.0 across the screen
```

Like all drawing, this has to run every frame.

## The GUI menu library (scripts/libs/GUI.lua)

A small button-list menu, drawn with natives. `main.lua` loads it into `Libs["GUI"]`.

| Function or field | What it does |
| --- | --- |
| `GUI.addButton(name, func, args, xmin, xmax, ymin, ymax)` | Adds a button. `func(args)` runs when it's activated. Positions are fractions of the screen (0.0 to 1.0); see the note below for what they really mean |
| `GUI.tick()` | Call every frame from your addin's `tick()`. Opens and closes the menu on the combos, moves the selection, runs the button, and draws |
| `GUI.init()` / `GUI.unload()` | Called by `main.lua`. `init` only sets `GUI.loaded` |
| `GUI.updateSelection()` | Moves the selection (Numpad 8 / 2 or D-pad) and activates the button (Space or A / Cross). Called by `tick` at most every 100 ms |
| `GUI.renderGUI()`, `GUI.renderButtons()` | Draw every button. Called by `tick` |
| `GUI.renderBox(xMin, xMax, yMin, yMax, r, g, b, a)` | Draws one box: calls `GRAPHICS.DRAW_RECT(xMin, yMin, xMax, yMax, r, g, b, a)`, which means centre x, centre y, width, height |
| `GUI.isKeyboardPressed(key)` | `get_key_pressed(key)` if available, otherwise `false` |
| `GUI.isControllerPressed(id)` / `GUI.isControllerHeld(id)` | `IS_CONTROL_JUST_PRESSED` / `IS_CONTROL_PRESSED` on control `id`, from `CONTROLS` (or `PAD` if a plugin names it that way) |
| `GUI.isComboPressed(combo)` | `true` on the frame the last button of a combo goes down while the others are held |
| `GUI.controller` | Control IDs: `Up` 188, `Down` 187, `Accept`/`A` 201, `Back`/`B` 202, `RB` 206, `LB` 205, `RL` (right stick click) 210, `LT` 207 |
| `GUI.openCombo`, `GUI.closeCombo` | `{ "A", "RB", "RL" }` opens, `{ "B", "LB", "LT" }` closes. Names from `GUI.controller` |
| `GUI.selection`, `GUI.buttonCount`, `GUI.hidden`, `GUI.menuOpen` | State |

**Positions:** `renderBox` passes its values to `DRAW_RECT(x, y, width, height)`, which draws a box centred on `x, y`. So `xmin` is really the centre x, `xmax` the width, and `ymax` the height. `ymin` is recalculated per button so buttons stack downwards.

**Using it in an addin:**

```lua
local mymenu = {}

function mymenu.heal()
    ENTITY.SET_ENTITY_HEALTH(PLAYER.PLAYER_PED_ID(), 200)
end

function mymenu.init()
    mymenu.GUI = Libs["GUI"]
    --              name    function      args  x    width  y-step  height
    mymenu.GUI.addButton("Heal", mymenu.heal, nil, 0.15, 0.2, 0.05, 0.04)
end

function mymenu.tick()
    mymenu.GUI.tick()
end

return mymenu
```

**Known problem in `exampleGUI.lua`:** its commented-out lines call `addButton("a", exampleGUI.kaboomb, 0, 0.2, 0.05, 0.05)` with 6 arguments, so `ymax` (the height) is `nil`. If you uncomment them as `LUA_MENU.md` describes, `DRAW_RECT` gets `nil` for the height and the buttons may not draw. Add a seventh value (for example `0.04`) to each line.

Also note: every addin that calls `GUI.tick()` shares the same button list, because `Libs["GUI"]` is one table.

## Debugging

There's no console and no log file: `print` output and the plugin's own error messages (`Main.lua: <error>`) aren't shown anywhere. So:

- **Show values on screen** with the text natives above, inside `tick()`.
- **Write a log file** with `io`:

  ```lua
  local f = io.open("scripts/mymod.log", "a")
  f:write(tostring(value), "\n")
  f:close()
  ```

- **Catch errors** so one bad addin doesn't stop the rest:

  ```lua
  local ok, err = pcall(function() --[[ your code ]] end)
  if not ok then
      local f = io.open("scripts/mymod.log", "a"); f:write(err, "\n"); f:close()
  end
  ```

- **A syntax error in any file stops every addin.** If nothing works after a change, undo it and check the syntax with an online Lua 5.2 checker.

## When to use Lua and when not

Lua is fine for small, personal tweaks. For anything bigger, use C# (SHVDN): current native names, a real menu library, an error console, a debugger, and a maintained API. Porting a Lua addin to C# is mostly renaming natives (see [guide 05](/scripting/natives.md#old-names-and-new-names)).
