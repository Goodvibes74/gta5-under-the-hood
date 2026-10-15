# Cookbook: UI and HUD

Messages, timers, blips, HUD changes. Part of the [mod-builder's cookbook](README.md).

## Systems it touches

| System | Guide |
| --- | --- |
| HUD components, colours, blips, radar | [HUD, colours and blips](/docs/ui/hud-colours-blips.md) |
| Scaleform movies | [Scaleform movies](/docs/ui/scaleform.md) |
| Text | [text labels](/docs/ui/text-labels.md) |
| Story screens | [story-mode UI](/docs/ui/story-mode-ui.md) |
| Pause menu | [pause and Online menus](/docs/ui/pause-menu.md) |
| Menus | [menus](menus.md) |

## Natives and files

- Hide HUD parts every frame: `HIDE_HUD_COMPONENT_THIS_FRAME` (6, 7, 9 for the corner texts).
- Big messages and prompts: `REQUEST_SCALEFORM_MOVIE("mp_big_message_freemode")`, `"instructional_buttons"`, `"midsized_message"`; methods; `DRAW_SCALEFORM_MOVIE_FULLSCREEN` every frame.
- Text on screen: `BEGIN_TEXT_COMMAND_DISPLAY_TEXT`, help with `BEGIN_TEXT_COMMAND_DISPLAY_HELP`, notifications with `BEGIN_TEXT_COMMAND_THEFEED_POST`.
- Colours: `GET_HUD_COLOUR` with a named colour index.
- Blips: `ADD_BLIP_FOR_*`, sprite, colour, name; `REMOVE_BLIP`.
- Layout changes: `frontend.xml` (positions), `hudcolor.dat` (colours).

## Traps

- **Draw every frame;** one-frame natives and draws vanish otherwise.
- **Release movies and remove blips** at cleanup.
- **Text that isn't in a loaded block** needs the literal-string commands.
- **Your UI under the pause menu:** check `IS_PAUSE_MENU_ACTIVE` before drawing.

## Minimal pattern: a timer with a big message

1. Request `mp_big_message_freemode` and `instructional_buttons`; wait until loaded.
2. Each frame: draw a timer with the text commands; hide HUD parts that clash.
3. At the end: call the big-message method, draw it full screen for three seconds.
4. Release the movies.

**Quick test:** run the timer in a car and on foot; the HUD corner texts stay hidden while it runs and return after.
