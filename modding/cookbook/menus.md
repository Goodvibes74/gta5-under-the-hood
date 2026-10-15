# Cookbook: menus

A trainer-style or settings menu. Part of the [mod-builder's cookbook](README.md).

## Systems it touches

| System | Guide |
| --- | --- |
| Menu libraries (LemonUI) | [menus and UI](/scripting/menus-and-ui.md), example [04_LemonMenu.cs](/examples/04_LemonMenu.cs) |
| Controls and key codes | [controls and camera](/docs/gameplay/player/controls-and-camera.md), [key codes](/docs/gameplay/player/keycodes-and-controls.md) |
| Text | [text labels](/docs/ui/text-labels.md) |
| The game's own pause menu | [pause and Online menus](/docs/ui/pause-menu.md) |
| Sounds | [audio](audio.md) |

## Natives and files

- Draw the menu with a library (LemonUI for C#, NativeUI-style libraries for Lua).
- Block the controls the menu uses while it's open: `DISABLE_CONTROL_ACTION` each frame.
- Keep the pause menu out: `DISABLE_FRONTEND_THIS_FRAME` while your menu is open; check `IS_PAUSE_MENU_ACTIVE` before drawing.
- Menu sounds: `PLAY_SOUND_FRONTEND(-1, "SELECT" / "BACK" / "NAV_UP_DOWN", "HUD_FRONTEND_DEFAULT_SOUNDSET", true)`.

## Traps

- **Controls leak through:** without disabling them, the player shoots or changes weapon while navigating.
- **Drawing every frame** is required; a menu drawn once vanishes.
- **Opening keys** clash with other mods (F4, F5, F7 are popular); make the key a setting.

## Minimal pattern

1. Build the menu once at start (items, callbacks).
2. Each frame: process the library's menus; if a menu is open, disable the clashing controls and the frontend.
3. A key (from the settings file) toggles the main menu.
4. Items call small functions; long work runs over several frames, not inside the click.

**Quick test:** open the menu in a car while moving; the car must not change radio, shoot or look around while you navigate.
