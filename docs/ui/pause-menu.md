# Pause and Online menus

How the pause menu ("frontend") is built: the data file that describes every screen, tab, option and setting, how a screen is filled by the engine or by a script, the five scripts that fill pause-menu pages, the natives scripts use to open, watch and talk to it, and what a mod can change. Roadmap topic **R8.1** in the [roadmap](/ROADMAP.md). Builds on [Scaleform movies](/docs/ui/scaleform.md) (R8.2: the movies the menu is drawn with) and [text labels](/docs/ui/text-labels.md) (R8.3).

**How it was made.** `update\update.rpf\common\data\ui\pausemenu.xml` (3,842 lines) and `frontend.xml` of build 1.0.3725.0, extracted with [`tools/rpf-cw.ps1`](/tools/README.md) and counted with `grep`. The page scripts (`pausemenu`, `pausemenu_map`, `pausemenu_multiplayer`, `pausemenu_sp_repeat`, `pausemenucareerhublaunch`, `pausemenu_example`) read in the decompile (commit `6c18d3e8b`); native counts from [native usage](/scripting/native-usage.md). Counts and names are **Verified**; how the engine walks the file is **Known** from the element names.

## 23.1 Short version

- **One XML file describes the whole pause menu:** `pausemenu.xml` has 154 screens (`MENU_UNIQUE_ID_*`), 23 of them headers (the tab bars for story mode, Online, lobbies, character creation, the save screen ...), 408 buttons, 214 options and 162 player settings (`PREF_*`).
- **Options do one of nine things:** change a setting (164), link to another screen (123), fill from the engine (37), refer to another screen (26), trigger an action (24), **fill from a script** (18), separator (9), placeholder and "incept" (1 each).
- **Screens are filled by 24 kinds of "runtime"**: the engine fills most (map, settings, stats, save game, gallery, friends, crews, party, players, keymap, store, video editor, lobby and invite lists), and 7 screens are filled by a script.
- **Scripts named in the file fill pages:** `PauseMenu_Map` (the map, story and Online), `PauseMenu_Multiplayer` (Online pages, 3.5 MB of decompiled code), `PauseMenu_SP_Repeat` (story replays), `PauseMenuCareerHubLaunch` (the career hub), and the Online `MP_Awards`, `MP_Unlocks` and `MP_Weapons` pages; the tiny `pausemenu` fills audio and display panes. Rockstar also ships `pausemenu_example`, an example page script.
- **Scripts talk to the open menu** with `BEGIN_SCALEFORM_MOVIE_METHOD_ON_FRONTEND` (10 scripts) and `PAUSE_MENU_ACTIVATE_CONTEXT` / `_DEACTIVATE_CONTEXT` (64 and 65 scripts), and watch it with `IS_PAUSE_MENU_ACTIVE` (616 scripts, 12,589 calls) and `GET_PAUSE_MENU_STATE` (371).
- **Most scripts only keep the menu away:** `DISABLE_FRONTEND_THIS_FRAME` (306 scripts, 7,245 calls), `SUPPRESS_FRONTEND_RENDERING_THIS_FRAME` (264) and `SET_FRONTEND_ACTIVE` (305) are far more common than opening a menu (`ACTIVATE_FRONTEND_MENU`, 3 scripts).

## 23.2 `pausemenu.xml`

| Element | Count | What it is |
| --- | ---: | --- |
| `MenuScreen` (`MENU_UNIQUE_ID_*`) | 154 distinct | A page or list |
| Header screens (`MENU_UNIQUE_ID_HEADER_*`) | 23 | Tab bars: story, multiplayer, lobby, pre-lobby, corona, race, betting, character select and creation, save game, landing page, joining screen ... |
| `CMenuButton` | 408 | Buttons and their inputs |
| `MenuOption` / `contextOption` | 214 / 203 | Entries in lists, and entries shown only in some contexts |
| `MenuPref` | 162 distinct | Settings saved in the profile (`PREF_GAMMA`, `PREF_DISPLAY_GPS`, `PREF_FPS_FIELD_OF_VIEW`, `PREF_GFX_CITY_DENSITY`, `PREF_AUTOSAVE`, `PREF_BIG_RADAR`, `PREF_FEED_*` ...) |
| `cGfxFilename` | 42 | The page movie to load (`PAUSE_MENU_PAGES_CORONA_PLAYERS`, `_CHAR_SELECT`, `_FRIENDS_MP`, `_STORE`, `_STATS`, `_SAVE`, `_CREWS`, `_WEAPONS`, `_SETTINGS`, `_MAP`, `_KEYMAP`, `_MISSIONCREATOR` ...) |
| `MovieSettings` | | Position and size of each movie on screen, per platform |

**Contexts** decide what shows: the most used are `*ALL*` (162), `DISPLAY_CORONA_BUTTONS` (79), `*NONE*` (62), `CORONA_BIGMAP_CLOSE` (24), `InMP` and `NAVIGATING_CONTENT`. Scripts switch contexts on and off with `PAUSE_MENU_ACTIVATE_CONTEXT` (344 calls) and `PAUSE_MENU_DEACTIVATE_CONTEXT` (487); the job creator, for example, activates the `creator` context ([R7.11](/docs/online/creator-internals.md)).

**Story-mode pages** include `MAP`, `MAP_LEGEND`, `INFO`, `STATS`, `SETTINGS` (with `_AUDIO`, `_CAMERA`, `_CONTROLS`, `_DISPLAY`, `_GRAPHICS`, `_ADVANCED_GFX`, `_FEED`, `_FIRST_PERSON`, `_REPLAY`, `_SAVEGAME`, `_VOICE_CHAT`), `GAME` (`NEW_GAME`, `LOAD_GAME`, `SAVE_GAME`, `REPLAY_MISSION`, `REPLAY_RANDOM`), `GALLERY`, `BRIEF` and `KEYMAP`. Online adds `HOME` (`_FEED`, `_NEWSWIRE`, `_OPEN_JOBS`, `_MISSION`), `PLAYERS`, `FRIENDS`, `CREWS`, `PARTY`, `MEDALS`, `WEAPONS`, `STORE`, `PROGRESS_HUB`, the lobby and corona lists, character creation (`CREATION_HERITAGE`, `_LIFESTYLE`, `_YOU`) and the creator (`MISSION_CREATOR`).

## 23.3 Who fills a screen

Each screen has a `runtime` block naming who fills it (**Verified**):

| Runtime type | Screens | Filled by |
| --- | ---: | --- |
| `SCRIPT` | 7 | A script named in the block: `PauseMenu_Multiplayer`, `PauseMenu_SP_Repeat`, `PauseMenuCareerHubLaunch`, `MP_Awards`, `MP_Unlocks`, `MP_Weapons` (six names) |
| `MAP` | 1 | The engine, with `PauseMenu_Map` running alongside (`path` and `sp_path`) |
| `SETTINGS`, `STATS`, `SAVEGAME`, `GALLERY`, `INFO`, `KEYMAP`, `STORETAB`, `VIDEOEDITORTAB`, `CUTSCENE` | 1 each | The engine |
| `FRIENDS`, `MPFRIENDS`, `CREW`, `CREWDETAILS`, `PARTY`, `PLAYERS`, `LOBBY`, six `CORONA_INVITE_*` types | 1 each | The engine, from the network and Social Club |

A script page is started with two parameters, the action and the screen's unique ID (`pausemenu` checks them and fills two panes, "PM_PANE_AUD" and "PM_PANE_DIS", with `DISPLAY_DATA_SLOT` on the frontend), and with `continual` set it keeps running while the screen is open.

## 23.4 The page scripts

| Script | Size | Role |
| --- | ---: | --- |
| `pausemenu_multiplayer` | 3.5 MB | Online pages: players, crews, job details, stats, awards |
| `pausemenu_map` | 255 KB | The map page: blips, legend, waypoints |
| `pausemenu_sp_repeat` | 87 KB | Story mission and strangers replay list |
| `pausemenucareerhublaunch` | 4 KB | Launches the career hub |
| `pausemenu_example` | 2 KB | Rockstar's example page script |
| `pausemenu` | 2 KB | Audio and display panes |

`mp_awards`, `mp_unlocks` and `mp_weapons` are the Online awards, unlocks and weapons pages. Other scripts that call into the frontend movie: `fmmc_launcher` (the corona) and `maintransition`.

## 23.5 What this means for modders

- **Keep the pause menu out of a mod's scene** the way Rockstar does: `DISABLE_FRONTEND_THIS_FRAME` every frame, or `SUPPRESS_FRONTEND_RENDERING_THIS_FRAME`.
- **Wait for it before drawing:** check `IS_PAUSE_MENU_ACTIVE` before showing your own UI; Rockstar does in 616 scripts.
- **Adding a real pause-menu page means editing `pausemenu.xml`** (a new screen, a `SCRIPT` runtime naming your script) and possibly a page movie. That is a data-file replacement in the mods folder ([archives and content](/docs/core/archives-and-content.md)), and every update that changes the file needs the edit again ([surviving updates](/docs/core/surviving-updates.md)). Script menu frameworks ([menus and UI](/scripting/menus-and-ui.md)) are the easier path.
- **The 162 `PREF_*` names** are the player's settings; scripts read them with `GET_PROFILE_SETTING` (633 scripts, 3,285 calls).

## 23.6 Open questions

| Question | Where it goes |
| --- | --- |
| The full tree: which header holds which tabs in story mode and Online | Second pass, walk `pausemenu.xml` |
| What `pausemenu_multiplayer` fills on each Online page | R8.5 |
| What `frontend.xml` sets (sizes and positions of HUD and menus) | R8.4 |

## 23.7 Test cards

1. **Disable.** In story mode, call `DISABLE_FRONTEND_THIS_FRAME` every tick while a key is held, and press Esc. Expected: the pause menu doesn't open while held.
