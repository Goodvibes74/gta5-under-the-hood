# 6. Your first Lua script

The same "heal on a key" idea from step 5, in Lua: no compiler, no project, just a text file. Part of the [modding path](README.md). The plugin in depth: [Lua](/scripting/lua.md).

## Short version

- The Lua Plugin for Script Hook V (`LUA.asi`, 1.0.0.1, 2015) runs Lua 5.2. It calls `init()` once and `tick()` every frame in `scripts\main.lua`, which in turn loads every file in `scripts\addins\` (**Verified** on the plugin's standard script set).
- You never edit `main.lua`: you add one file to `scripts\addins\`.
- Natives use their **2015 names** (`UI` instead of today's `HUD`, `GAMEPLAY` instead of `MISC`). The [Lua guide](/scripting/lua.md#calling-natives) has the mapping.
- There is no console and no log: show values on screen or write your own log file.
- Good for small personal tweaks. For anything bigger, C# is the better tool.

## 1. Install the plugin

Download "Lua Plugin for Script Hook V" from gta5-mods.com and follow its readme. You end up with `LUA.asi` in the game folder and, in `scripts`, `main.lua`, `keys.lua`, `utils.lua`, a `libs` folder and an `addins` folder (with `basemodule.lua` as a template). Add the new files to your list from [step 3](03-install-and-check.md#2-keep-a-list-and-a-way-back). Start the game once and check `asiloader.log` lists `LUA.asi`.

## 2. Write the addin

Create `scripts\addins\firstmod.lua`:

```lua
local firstmod = {}

local wasDown = false

local function notify(text)
    UI._SET_NOTIFICATION_TEXT_ENTRY("STRING")     -- today: HUD.BEGIN_TEXT_COMMAND_THEFEED_POST
    UI._ADD_TEXT_COMPONENT_STRING(text)           -- today: HUD.ADD_TEXT_COMPONENT_SUBSTRING_PLAYER_NAME
    UI._DRAW_NOTIFICATION(false, true)            -- today: HUD.END_TEXT_COMMAND_THEFEED_POST_TICKER
end

function firstmod.init()
    -- runs once when the addin loads
end

function firstmod.tick()
    -- runs every frame: keep it fast
    local down = get_key_pressed(Keys.Pause)      -- true while the key is held; pick a free key
    if down and not wasDown then                  -- act only on the frame the key goes down
        local me = PLAYER.PLAYER_PED_ID()
        ENTITY.SET_ENTITY_HEALTH(me, ENTITY.GET_ENTITY_MAX_HEALTH(me))
        PED.SET_PED_ARMOUR(me, 100)
        notify("Healed by my first Lua mod")
    end
    wasDown = down
end

function firstmod.unload()
end

return firstmod
```

Start the game, load story mode, lose some health, press the key.

## 3. What's different from C#

| | C# (step 5) | Lua (this step) |
| --- | --- | --- |
| Keys | A `KeyDown` event fires once per press | `get_key_pressed` is true *while* held, so you track `wasDown` yourself |
| Natives | Wrapped in classes (`Game.Player.Character.Health`) | Called directly by name, `NAMESPACE.NAME(...)` |
| Native names | Current | 2015 names; post-2015 natives are missing |
| Errors | Shown in the F4 console and logged | Not shown anywhere. A syntax error in any file stops every addin |
| Reload | `Reload()` in the console | Restart the game |

## 4. Debugging without a console

Write a tiny log helper and wrap risky code in `pcall`, so one error doesn't silently stop everything:

```lua
local function log(text)
    local f = io.open("scripts/firstmod.log", "a")
    if f then f:write(tostring(text), "\n"); f:close() end
end

-- inside tick():
local ok, err = pcall(function()
    -- your code
end)
if not ok then log(err) end
```

Only log on errors or key presses, never every frame: writing a file 60 times a second makes the game stutter.

## Exercises

1. Show your speed on screen while driving, like step 5, part 2. You'll need `PED.IS_PED_IN_ANY_VEHICLE`, `PED.GET_VEHICLE_PED_IS_IN`, `ENTITY.GET_ENTITY_SPEED` and the text natives in the [Lua guide](/scripting/lua.md#drawing-text).
2. Make a typo on purpose (remove an `end`). Watch every Lua addin stop. Fix it. Now you know why the `pcall` habit matters.
3. Port this addin to C# and compare the length of the two files.

Next: [7. Your first C++ mod](07-first-asi-mod.md) or [8. Debugging](08-debugging.md).
