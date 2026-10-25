# Pause and Online menus

How the pause menu ("frontend") is built: the data file that describes every screen, tab, option and setting, how a screen is filled by the engine or by a script, the five scripts that fill pause-menu pages, the natives scripts use to open, watch and talk to it, and what a mod can change. Roadmap topic **R8.1** in the [roadmap](/ROADMAP.md). Builds on [Scaleform movies](/docs/ui/scaleform.md) (R8.2: the movies the menu is drawn with) and [text labels](/docs/ui/text-labels.md) (R8.3).

**How it was made.** `update\update.rpf\common\data\ui\pausemenu.xml` (3,842 lines) and `frontend.xml` of build 1.0.3725.0, extracted with [`tools/rpf-cw.ps1`](/tools/README.md) and counted with `grep`. The page scripts (`pausemenu`, `pausemenu_map`, `pausemenu_multiplayer`, `pausemenu_sp_repeat`, `pausemenucareerhublaunch`, `pausemenu_example`) read in the decompile (commit `6c18d3e8b`); native counts from [native usage](/scripting/native-usage.md). Counts and names are **Verified**; how the engine walks the file is **Known** from the element names. The second pass (2026-10-25, sections 23.5 and 23.6) walked every link from each menu version with a small reader, looked up the tab names in `global.gxt2`, matched the hashes scripts pass to `ACTIVATE_FRONTEND_MENU` to the `joaat` of each version name, and read `frontend.xml` against its base copy in `common.rpf`.

## 23.1 Short version

- **One XML file describes the whole pause menu:** `pausemenu.xml` has 154 screens (`MENU_UNIQUE_ID_*`), 23 of them headers (the tab bars for story mode, Online, lobbies, character creation, the save screen ...), 408 buttons, 214 options and 162 player settings (`PREF_*`).
- **Options do one of nine things:** change a setting (164), link to another screen (123), fill from the engine (37), refer to another screen (26), trigger an action (24), **fill from a script** (18), separator (9), placeholder and "incept" (1 each).
- **Screens are filled by 24 kinds of "runtime"**: the engine fills most (map, settings, stats, save game, gallery, friends, crews, party, players, keymap, store, video editor, lobby and invite lists), and 7 screens are filled by a script.
- **Scripts named in the file fill pages:** `PauseMenu_Map` (the map, story and Online), `PauseMenu_Multiplayer` (Online pages, 3.5 MB of decompiled code), `PauseMenu_SP_Repeat` (story replays), `PauseMenuCareerHubLaunch` (the career hub), and the Online `MP_Awards`, `MP_Unlocks` and `MP_Weapons` pages; the tiny `pausemenu` fills audio and display panes. Rockstar also ships `pausemenu_example`, an example page script.
- **Scripts talk to the open menu** with `BEGIN_SCALEFORM_MOVIE_METHOD_ON_FRONTEND` (10 scripts) and `PAUSE_MENU_ACTIVATE_CONTEXT` / `_DEACTIVATE_CONTEXT` (64 and 65 scripts), and watch it with `IS_PAUSE_MENU_ACTIVE` (616 scripts, 12,589 calls) and `GET_PAUSE_MENU_STATE` (371).
- **Most scripts only keep the menu away:** `DISABLE_FRONTEND_THIS_FRAME` (306 scripts, 7,245 calls), `SUPPRESS_FRONTEND_RENDERING_THIS_FRAME` (264) and `SET_FRONTEND_ACTIVE` (305) are far more common than opening a menu (`ACTIVATE_FRONTEND_MENU`, 3 scripts).
- **25 menu versions share the one file** (second pass, [23.5](#235-the-full-tree-menu-versions-tabs-and-panes)): the story and Online pause menus, the save screen, the character creator, the landing page and 10 corona (job lobby) screens. The story pause menu has 10 tabs, Online 9; the Online tab is still the screen called `MISSION_CREATOR`. Scripts open a version only 25 times, from `fmmc_launcher`, `maintransition` and `director_mode`.
- **`frontend.xml` places the HUD** ([23.6](#236-frontendxml-where-the-hud-and-menus-sit)): 21 engine and 23 script HUD items with position, colour, draw depth and a stacking list, the radar rectangles, 8 fake radar interiors, and the warning-screen buttons.

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

## 23.5 The full tree: menu versions, tabs and panes

*Second pass (2026-10-25).* Walked from `pausemenu.xml` (update copy) by following every `MENU_OPTION_ACTION_LINK` from each menu version's first screen, with the tab names looked up in `global.gxt2` (American). Who opens each version was counted from `ACTIVATE_FRONTEND_MENU` calls in the decompile, with the hash in the first argument matched to the `joaat` of each `FE_MENU_VERSION_*` name. All **Verified** for build 3725.

**A menu version is a whole menu.** The file defines **25 menu versions** (`FE_MENU_VERSION_*`). Each names its first screen (always a header, the tab bar), a title label, the contexts switched on when it opens (`InSP`, `InMP`, `InLobby` ...) and flags such as `kNoBackground`, `kNoTabChange` or `kTabsAreColumns`. The story pause menu, the Online pause menu, the save screen, the character creator and every corona screen are all versions of the one menu.

| Menu version | Title | Opened by |
| --- | --- | --- |
| `SP_PAUSE` | "Grand Theft Auto V" | The engine (the pause key in story mode); no script call |
| `MP_PAUSE` | "Grand Theft Auto Online" | The engine in Online; `maintransition` once |
| `CREATOR_PAUSE` | "Creator" | The engine in the creators (same tabs as story mode) |
| `CUTSCENE_PAUSE` | none | The engine during a cutscene (an empty screen with buttons) |
| `SAVEGAME` | "Save Game" | The engine, when a script asks for the save menu (`SET_SAVE_MENU_ACTIVE`, **Known**); no `ACTIVATE_FRONTEND_MENU` call |
| `PRE_LOBBY`, `LOBBY` | "Multiplayer / Pre-Lobby", "Multiplayer / Lobby" | No script call in this build (old console lobby) |
| `MP_CHARACTER_SELECT` | "Multiplayer / Character Select" | No script call in this build |
| `MP_CHARACTER_CREATION` | none | `maintransition` (1 call) |
| `EMPTY`, `EMPTY_NO_BACKGROUND` | none | `EMPTY_NO_BACKGROUND`: `maintransition` (4 calls), `director_mode` (1) |
| `TEXT_SELECTION` | none (one tab, "LOBBY LIST") | `maintransition` (3 calls) |
| `JOINING_SCREEN` | none (one tab, "PLAYERS") | `maintransition` (1 call) |
| `CORONA`, `CORONA_LOBBY`, `CORONA_RACE`, `CORONA_BETTING` | none | `fmmc_launcher` (2, 1, 3 and 1 calls) |
| `CORONA_JOINED_PLAYERS` and the five `CORONA_INVITE_*` versions | none | `fmmc_launcher` (1 call each, 2 for last-job players) |
| `LANDING_MENU`, `LANDING_KEYMAPPING_MENU` | none | The engine's landing page (settings and key bindings only) |

Scripts call `ACTIVATE_FRONTEND_MENU` 25 times in three scripts: `fmmc_launcher` 15 (the job lobby, [R7.5](/docs/online/job-lobby.md)), `maintransition` 10 (the moves between story mode and Online, [R7.2](/docs/online/transitions-and-sessions.md)) and `director_mode` 1. One `fmmc_launcher` call passes the version in a variable.

**The tabs of the two pause menus** (in the order the file lists them; "filled by" from each screen's `runtime` block):

| Tab | Screen | Story mode | Online | Filled by |
| --- | --- | :---: | :---: | --- |
| MAP | `MAP` | 1 | 1 | The engine, with `PauseMenu_Map` |
| BRIEF / INFO | `INFO` | 2 ("BRIEF") | 5 ("INFO") | The engine |
| STATS | `STATS` | 3 | 8 | The engine |
| SETTINGS | `SETTINGS` | 4 | 7 | The engine |
| GAME | `GAME` | 5 | | `PauseMenu_SP_Repeat` |
| ONLINE | `MISSION_CREATOR` | 6 | 2 | `PauseMenu_Multiplayer` (keeps running while open) |
| CAREER | `PROGRESS_HUB` | | 3 (PS5 and Xbox Series only) | `PauseMenuCareerHubLaunch` |
| FRIENDS | `FRIENDS` / `FRIENDS_MP` | 7 | 4 | The engine (Social Club friends) |
| GALLERY | `GALLERY` | 8 | 9 | The engine |
| STORE | `STORE` | 9 | 6 | The engine |
| ROCKSTAR EDITOR | `REPLAY_EDITOR` | 10 (not in the creators) | | The engine |

The screen behind the **ONLINE** tab is still named `MENU_UNIQUE_ID_MISSION_CREATOR` (its movie is `PAUSE_MENU_PAGES_MISSIONCREATOR`), a leftover from when the tab opened the creator. It holds no options of its own: its entries are *references* to the Crews, Players, Friends, Party, Weapons, Awards and Unlocks screens, which `PauseMenu_Multiplayer` shows inside the tab (the Online-only ones with the `InMP` context). In the Online pause menu, the Crews, Weapons and Awards tabs are commented out of the header with the note that they moved into the Online tab. What the script puts on that tab is question UI-005 ([R8.5](/docs/ui/server-backed-screens.md)).

**Under the tabs:**

- **BRIEF / INFO** has six panes: Mission (story) or Jobs (Online), Help, Dialogue, Notifications, and Rockstar Newswire (hidden with the `DisableNewswire` context).
- **SETTINGS** has 16 panes, the same in story mode, Online, the creator and the landing page. The number is how many entries each holds (settings, plus a "restore defaults" action in most): Gamepad (22), Keyboard / Mouse (22, PC only), Key Bindings (opens the `KEYMAP` screen, PC only), Audio (24), Camera (12), Display (18), Graphics (38, PC), Advanced Graphics (8, PC), Voice Chat (16), Notifications (8), Rockstar Editor (5, only with the `ReplayEditor` context), Saving And Startup (3), Facebook (4, hidden when Facebook is off), Additional Settings (4, only with `AgeAssuranceEnabled`), and two console panes (`SETTINGS_SIXAXIS` on PS4, a controller pane off PC).
- **GAME** (story mode and the creator only) has Replay Mission, Replay Strangers and Freaks, Load Game, New Game, the console save import and processing panes, Legal, Credits (the credits and legal panes show only with `CREDITS_ENABLED` / `LEGAL_ENABLED`, never in the creator) and Quit Game (PC).
- **The save screen** (`SAVEGAME` version) has one tab, SAVE.
- **The character creator** (`MP_CHARACTER_CREATION`) has three tabs, OPTIONS (`CREATION_HERITAGE`), DETAILS (`CREATION_LIFESTYLE`) and YOU (`CREATION_YOU`); the character select version has five "NEW CHARACTER" slots (`MP_CHAR_1` to `_5`). The creator itself is drawn by script, not by these screens ([the Online character creator](/docs/gameplay/player/online-character-creator.md)).
- **The corona versions** (the job lobby) each have one to three column tabs: settings, players and details for `CORONA`; invite, players and recently joined character for `CORONA_LOBBY`; joined players, character and player card for each invite list; options for a race; betting.

**Script pages named in the file:** besides the five scripts in [23.3](#233-who-fills-a-screen), two screens name a `path` that is not a script in this build: `SP_MENUPED` (story Friends and Crew details) and `MP_MENUPED` (Online Friends and Party). Both pages show the player's ped next to the list, so the names probably pick the menu ped set-up rather than a script (**Known**, from the names only). The `LOBBY` screen names `MP_Awards`.

## 23.6 `frontend.xml`: where the HUD and menus sit

*Second pass (2026-10-25).* Read from `update\update.rpf\common\data\ui\frontend.xml` (506 lines) and compared with the base copy in `common.rpf`. **Verified** for build 3725, except what the engine does with `listId` (**Known**, see below).

The file holds placement data, not logic. Its sections:

| Section | What it sets | Count |
| --- | --- | ---: |
| `Hud` | The engine's HUD components: position, size, alignment (`L`/`C`/`R`, `T`/`B`), colour, alpha, draw depth, a list ID and priority, and whether each has its own movie | 21 (wanted stars, weapon icon, cash, Online cash and messages, vehicle, area and street names, help text and two floating help texts, cash change, reticle, subtitles, radio wheel, saving icon, weapon wheel and its stats ...) |
| `ScriptHud` | The same for HUD items scripts turn on | 23 (four drug purses, 11 `HUD_MP_TAG_*` carry icons such as packages, keys, key card and cuff keys, three `HUD_MP_VEHICLE*` icons, the switch alert, the rank bar, the director mode tag, casino chips and chip change) |
| `minimap` | The radar, big radar, pause-map, gallery and golf-course map rectangles, each with its mask and blur | 11 |
| `minimap_interiors` | Fake interiors the radar draws for big underground spaces: the Doomsday base, the metro, the storm-drain tunnel and others, each with its position and the interior pieces it covers | 8 interiors, 100 pieces |
| `PauseMenu` | The loading spinner and its column offsets (including where the character-select slots and the character creator's mum, dad and "you" sit), the background gradient and the tab arrows | |
| `CommerceStore`, `ReplayHud`, `GameStream` | The store frame (16:9 and 4:3), the Rockstar Editor overlays (10 components), the feed's position and the last loading tip number (`gametips lasttip="153"`) | |
| `WarningScreen`, `TextEntryBox` | The buttons a warning screen or text box can show, by bit (`BitIndex` 0 = select, 1 = OK, 2 = yes, 3 = back ...) | 38 and 31 |

**The top-right stack (question UI-002, partly).** Every HUD item with `listId="1"` sits at the top right, and `listPriority` orders them: director mode 0, wanted stars 1, Online cash 2, Online messages 3, cash 4, cash change 5, weapon icon 6, chips 7 and chip change 8 (the drug purses use 8 to 11 and the weapon-wheel stats 9), and the script tags and vehicle icons 12 to 25. The help texts use list 2, and items that never stack use `-1`. So the list is a column of items that push each other down in priority order (**Known**, from the values and what the game shows; the engine code was not read). Compared with the base file, the update raised the six engine items in list 1 by one, so the wanted stars no longer share 0 with director mode, moved the weapon-wheel stats from 6 to 9 and widened them (`sizeX` 0.098 to 0.1156). `depth` is the draw order (higher on top): the saving icon has 2,000, far above everything else.

For a mod, this is the file to edit to move the radar or a HUD item, as a data-file replacement ([archives and content](/docs/core/archives-and-content.md)); scripts can move only some of it at run time (`SET_HUD_COMPONENT_POSITION`, `SET_MINIMAP_COMPONENT` ... in [HUD, colours and blips](/docs/ui/hud-colours-blips.md)).

## 23.7 What this means for modders

- **Keep the pause menu out of a mod's scene** the way Rockstar does: `DISABLE_FRONTEND_THIS_FRAME` every frame, or `SUPPRESS_FRONTEND_RENDERING_THIS_FRAME`.
- **Wait for it before drawing:** check `IS_PAUSE_MENU_ACTIVE` before showing your own UI; Rockstar does in 616 scripts.
- **Adding a real pause-menu page means editing `pausemenu.xml`** (a new screen, a `SCRIPT` runtime naming your script) and possibly a page movie. That is a data-file replacement in the mods folder ([archives and content](/docs/core/archives-and-content.md)), and every update that changes the file needs the edit again ([surviving updates](/docs/core/surviving-updates.md)). Script menu frameworks ([menus and UI](/scripting/menus-and-ui.md)) are the easier path.
- **The 162 `PREF_*` names** are the player's settings; scripts read them with `GET_PROFILE_SETTING` (633 scripts, 3,285 calls).

## 23.8 Open questions

| Question | Where it goes |
| --- | --- |
| What `SP_MENUPED` and `MP_MENUPED` select, and why the `LOBBY` screen names `MP_Awards` | Engine reverse engineering, or an in-game test with the Friends page |
| How the engine places the items of HUD list 1 (`listId`) when several show at once | In-game test card 2 |

Answered in the second pass: what `pausemenu_multiplayer` puts on the ONLINE tab ([server-backed screens 25.5](/docs/ui/server-backed-screens.md#255-the-online-tab-entry-by-entry)), the full tree ([23.5](#235-the-full-tree-menu-versions-tabs-and-panes)) and what `frontend.xml` sets ([23.6](#236-frontendxml-where-the-hud-and-menus-sit)).

## 23.9 Test cards

1. **Disable.** In story mode, call `DISABLE_FRONTEND_THIS_FRAME` every tick while a key is held, and press Esc. Expected: the pause menu doesn't open while held.
2. **The top-right stack.** In story mode, get a wanted level while holding a weapon and pick up cash (or spend some at a shop). Expected, from `frontend.xml`: wanted stars on top, then the cash and the cash change, then the weapon icon below them. Note the order you see; if it differs, the engine does more with `listPriority` than sort.
