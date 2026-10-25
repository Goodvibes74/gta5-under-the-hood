# Scaleform movies

The game's 2D interface is made of Scaleform (Flash) movies: where the `.gfx` files are, how many there are and what each group draws, how scripts load a movie and call its methods, which movies and methods Rockstar's scripts use most, and what a mod can do with them. Roadmap topic **R8.2** in the [roadmap](/ROADMAP.md). Builds on [text labels](/docs/ui/text-labels.md) (R8.3: the text that goes into movies) and [natives as the engine API](/scripting/natives-engine-api.md) (R1.3: ask-then-wait and one-frame natives).

**How it was made.** Every `.gfx` in `x64b.rpf`, `update\update.rpf` and `update\update2.rpf` was listed with [`tools/rpf-cw.ps1`](/tools/README.md) `-Pattern "*.gfx"` (DLC packs not scanned). Every literal movie name passed to `REQUEST_SCALEFORM_MOVIE*` and every method name passed to `BEGIN_SCALEFORM_MOVIE_METHOD*` was pulled from the build 1.0.3725.0 decompile (commit `6c18d3e8b`) with `git grep` and counted by script. Native counts from [native usage](/scripting/native-usage.md). Counts and names are **Verified**; what a movie looks like and what a method does are **Known** from the names.

## 22.1 Short version

- **1,080 `.gfx` files, 788 distinct names,** in seven nested archives: `scaleform_generic` (327 names), `scaleform_minimap` (285, of which 283 are interior maps named `int<hash>.gfx`), `scaleform_web` (the browser plus 86 websites), `scaleform_generic_2` (44, newer DLC screens), `scaleform_frontend` (27: pause menu, loading screens, store), `scaleform_minigames` (12) and `scaleform_platform_pc` (9: fonts and PC keymaps). The update archive holds newer copies of most of them.
- **Scripts load 121 movies by name** (1,710 request calls) and probably more through variables; 116 of them are among the files found.
- **The busiest movies are shared overlays:** `mp_mm_card_freemode` (the player list, requested in 198 scripts), `instructional_buttons` (197), `mp_spectator_card` (196), `mp_matchmaking_card` (196), `breaking_news` (73), `social_club_tv` (70), `mp_big_message_freemode` (50, the big centre messages), `security_cam` (43), `midsized_message` (39), `countdown` (32).
- **Calling a method is four steps:** `BEGIN_SCALEFORM_MOVIE_METHOD` (525 scripts, 14,456 calls), parameters (`ADD_PARAM_INT` 27,091 calls, text through `BEGIN_TEXT_COMMAND_SCALEFORM_STRING` 10,657, bool, float, texture and player-name parameters), `END_SCALEFORM_MOVIE_METHOD`, and drawing every frame (`DRAW_SCALEFORM_MOVIE_FULLSCREEN` 345 scripts, `DRAW_SCALEFORM_MOVIE` 366, `_3D_SOLID` 41 for screens in the world).
- **690 method names** are called with literal names; the top ten are `SET_DATA_SLOT` (2,557 calls), `TOGGLE_MOUSE_BUTTONS` (826), `SET_TITLE` (671), `DRAW_INSTRUCTIONAL_BUTTONS` (406), `SET_INPUT_EVENT` (405), `SET_SCROLL_TEXT` (367), `CLEAR_ALL` (355), `SET_DATA_SLOT_EMPTY` (333), `SET_MAX_WIDTH` (330), `OVERRIDE_RESPAWN_TEXT` (275).
- **The pause menu is a special case:** scripts talk to it with `BEGIN_SCALEFORM_MOVIE_METHOD_ON_FRONTEND` (10 scripts, 187 calls) and `_ON_FRONTEND_HEADER` rather than loading it.

## 22.2 Where the movies are

| Archive (inside `x64b.rpf` and `update.rpf`) | Distinct movies | What they draw |
| --- | ---: | --- |
| `scaleform_generic.rpf` | 327 | Almost everything scripts load: HUD messages, cards, phone skins, cameras, hacking games, computers, signs |
| `scaleform_minimap.rpf` | 285 | The radar (`minimap`, `minimap_main`), 283 interior maps (`int<number>.gfx`), golf courses |
| `scaleform_web.rpf` | 87 | `web_browser` and 86 websites, one movie per site (`www_abstinentamerica_com` ...) |
| `scaleform_generic_2.rpf` | 44 | Newer DLC screens: `auto_shop_board`, `avenger_operations_terminal`, `bounty_computer`, `drag_race`, `fixer_app` ... |
| `scaleform_frontend.rpf` | 27 | Pause menu parts (`pause_menu_header`, `_pages_settings`, `_pages_keymap`, `_sp_content`, `_store_content`, shared components), loading screens, `landing_page`, `opening_credits`, `popup_warning`, `social_club2`, `busy_spinner`, `mouse_pointer` |
| `scaleform_minigames.rpf` | 12 | `golf`, `tennis`, `darts_scoreboard`, `horse_racing_*`, `spin_the_wheel`, `sc_leaderboard`, `axe_of_fury`, `dancer` |
| `scaleform_platform_pc.rpf` | 9 | PC fonts (Chinese, Japanese, Korean, EFIGS), `language_select_pc`, keymaps for tattoos and yoga, `gamepad_calibration` |

DLC packs add only 28 movies, in two packs (second pass, [22.5](#225-every-movie-its-methods-and-who-names-it)); later updates put theirs in `update.rpf`.

## 22.3 How a script uses a movie

The pattern is the same everywhere (**Verified**, counts from the native tables):

| Step | Natives | Scripts | Calls |
| --- | --- | ---: | ---: |
| Load | `REQUEST_SCALEFORM_MOVIE` (or `_INSTANCE` for a second copy) | 464 (60) | 1,911 (99) |
| Wait | `HAS_SCALEFORM_MOVIE_LOADED` | 492 | 5,811 |
| Call | `BEGIN_SCALEFORM_MOVIE_METHOD` … `END_SCALEFORM_MOVIE_METHOD` | 525, 531 | 14,456, 14,215 |
| Parameters | `ADD_PARAM_INT`, `_BOOL`, `_FLOAT`, `_TEXTURE_NAME_STRING`, `_PLAYER_NAME_STRING`, `_LITERAL_STRING` | 511, 427, 342, 224, 387, 105 | 27,091, 4,408, 3,165, 1,358, 696, 260 |
| Text parameter | `BEGIN_TEXT_COMMAND_SCALEFORM_STRING` … `END_TEXT_COMMAND_SCALEFORM_STRING` | 502 | 10,657 |
| Shortcuts | `CALL_SCALEFORM_MOVIE_METHOD`, `_WITH_NUMBER`, `_WITH_NUMBER_AND_STRING` | 181, 60, 23 | 512, 1,666, 243 |
| Read a result | `END_SCALEFORM_MOVIE_METHOD_RETURN_VALUE`, `IS_SCALEFORM_MOVIE_METHOD_RETURN_VALUE_READY`, `GET_SCALEFORM_MOVIE_METHOD_RETURN_VALUE_INT` | 93, 70, 69 | 441, 434, 250 |
| Draw (every frame) | `DRAW_SCALEFORM_MOVIE_FULLSCREEN`, `DRAW_SCALEFORM_MOVIE`, `DRAW_SCALEFORM_MOVIE_3D_SOLID` | 345, 366, 41 | 1,038, 660, 60 |
| Release | `SET_SCALEFORM_MOVIE_AS_NO_LONGER_NEEDED` | 538 | 2,524 |

Text goes in as a label through the text command, so a movie shows the player's language; return values arrive a frame or more later and must be polled.

## 22.4 The busiest movies

Requested by literal name in the most scripts (**Verified**):

| Movie | Scripts | Draws (**Known**) |
| --- | ---: | --- |
| `mp_mm_card_freemode` | 198 | The Online player list |
| `instructional_buttons` | 197 | The button prompts in the bottom corner |
| `mp_spectator_card`, `mp_matchmaking_card` | 196 each | Player cards in spectating and lobbies |
| `breaking_news` | 73 | The Weazel News overlay |
| `social_club_tv`, `mp_spectator_overlay` | 70 each | Spectator TV |
| `mp_big_message_freemode` | 50 | Big centre messages ("MISSION PASSED", "WASTED") |
| `security_cam` | 43 | Security camera overlay |
| `midsized_message` | 39 | Medium messages |
| `countdown` | 32 | 3-2-1-GO |
| `sc_leaderboard` | 26 | Leaderboards |
| `hacking_pc` | 22 | The hacking minigame |
| `mp_celebration`, `_fg`, `_bg` | 19 each | End-of-job celebration screen |
| `vault_laser`, `vault_drill` | 14 each | Heist drill and laser |
| `saving_footer`, `blimp_text` | 12 each | Save icon, blimp sign |

**Method names.** 690 distinct names are called literally. Beyond the top ten in 22.1: `SET_HIGHLIGHT`, `SET_INPUT_EVENT_SELECT`, `DISPLAY_VIEW`, `COLLAPSE`, `DISPLAY_SCROLL_TEXT`, `SET_ICON`, `SET_BACKGROUND_COLOUR`, `SHOW_TICKER`, `ADD_BACKGROUND_TO_WALL`, `SET_SLOT`, `SHOW_STAT_WALL`, `CREATE_STAT_WALL`, `CLEANUP`, `SET_TEXT`, `SET_MESSAGE`. List-style movies share `SET_DATA_SLOT` / `DISPLAY_VIEW` / `SET_DATA_SLOT_EMPTY`; message movies use `SHOW_SHARD_*` and `SET_MESSAGE`-style methods.

## 22.5 Every movie, its methods and who names it

*Second pass (2026-10-25).* Every `.gfx` in `x64b.rpf`, `update\update.rpf` and the DLC packs was extracted with [`tools/rpf-cw.ps1`](/tools/README.md) and read with a small reader of the movie's ActionScript 2 (the SWF action records inside the `.gfx`: constant pools, and the name pushed just before each function definition, which is how an ActionScript class method is written). The update's copy wins over the DLC copy, and both over the base copy. The method names were then matched with every method name scripts pass to `BEGIN_SCALEFORM_MOVIE_METHOD*` and `CALL_SCALEFORM_MOVIE_METHOD*` in the decompile (commit `6c18d3e8b`). **Verified** counts.

**DLC packs ship almost no movies.** Only two of the 89 packs carry any: `mpheist` (26: the heist planning board `heist_mp`, `heistmap_mp`, the heist celebration screens, drilling and hacking screens, eight interior maps and a few website movies) and `mpapartment` (2). Every later update put its movies into `update\update.rpf` instead (`scaleform_generic_2.rpf` and the others). With them, the game has **793 distinct movies**: 511 screens and 282 interior maps.

**Methods.** The 793 movies define **8,181 methods with 1,965 distinct names**. Scripts call 723 distinct method names; **712 of them are defined in some movie**. The 11 that no movie defines (`ADD_GAMES_WON_TO_WALL`, `CLEAR_GALLERY`, `CLEAR_WEAPONS`, `HIDE_DJ_INFO_PANEL`, `IS_LOAD_ANIM_FINISHED`, `LOCK_RIGHTMOUSE_CLICK`, `SET_MISSION_NAME`, `SET_PLAYERS_NEEDED`, `SET_SCOREBOARD`, `SET_SCOREPANEL`, `SET_SOCIAL_CLUB_INFO`) are calls into methods that were removed or renamed, which Scaleform ignores (**Known**). The function definitions also keep their **parameter names**, which tell what each argument is. Examples from the most used movies (**Verified**):

| Movie | Methods (parameters) |
| --- | --- |
| `midsized_message` | `SHOW_MIDSIZED_MESSAGE(title, description)`, `SHOW_BRIDGES_KNIVES_PROGRESS(title, totalToDo, message, info, completed)`, `SHOW_SHARD_MIDSIZED_MESSAGE(bigText, msgText)`, `SHARD_ANIM_OUT(colID, animTime)` |
| `mp_big_message_freemode` | 47 methods, among them `SHOW_SHARD_WASTED_MP_MESSAGE(bigTxt, msgTxt, colId, someUnusedBoolean, darkenBackground)`, `DO_SHARD(args, isCenter, colID, shardColID, useLargeShard)`, `SHOW_MISSION_PASSED_MESSAGE` (no named parameters; [story-mode UI](/docs/ui/story-mode-ui.md)) |
| `countdown` | `SET_MESSAGE(newString, r, g, b, isMP)`, `FADE_SP(newString, r, g, b)`, `FADE_MP(...)`, `OVERRIDE_FADE_DURATION(newFadeDuration)`, `IS_COUNTDOWN_VISIBLE()` |
| `breaking_news` | `SET_TEXT(titleT, subT)`, `SET_SCROLL_TEXT(slot, id, str)`, `DISPLAY_SCROLL_TEXT(slot, id, scrollSpeed)`, `CLEAR_SCROLL_TEXT(slot)`, `SHOW_STATIC(staticType)` |
| `security_cam` | `SET_LAYOUT(type)`, `SET_LOCATION(loc)`, `SET_DETAILS(details)`, `SET_TIME(hh, mm, ss, tt)` |
| `mp_mm_card_freemode` | `SET_TITLE(str, str2, icon)`, `SET_DATA_SLOT(_viewIndex)` (reads the rest as extra arguments), `SET_ICON(index, iconEnum, rank)`, `COLLAPSE(collapse)`, `DISPLAY_VIEW()` |
| `instructional_buttons` | 25 methods: `CLEAR_ALL`, `SET_DATA_SLOT`, `DRAW_INSTRUCTIONAL_BUTTONS`, `SET_BACKGROUND_COLOUR`, `SET_MAX_WIDTH`, `OVERRIDE_POSITION`, `FLASH_BUTTON_BY_ID`, `TOGGLE_MOUSE_BUTTONS`, `SET_SAVING_TEXT`, `REMOVE_SAVING` ... |
| `mp_celebration` | `CREATE_STAT_WALL(id, colourName, fgAlpha)`, `ADD_SCORE_TO_WALL(wallId, textLabel, score)`, `ADD_REP_POINTS_AND_RANK_BAR_TO_WALL(wallId, repPointsGained, startRepPoints, minRepPointsForRank, maxRepPointsForRank, currentRank, nextRank)`, `SHOW_STAT_WALL(wallId)`, `CLEANUP(wallId)` ... |
| `hacking_pc` | 61 methods: the desktop (`OPEN_APP(id)`, `SET_CURSOR(vx, vy)`), the IP and roulette hacks (`SET_IP_OUTCOME(success, winStr)`, `SET_ROULETTE_WORD(wordStr)`, `SET_COLUMN_SPEED(columnIndex, speed)`), lives and countdown (`SET_LIVES(lives, total)`, `SET_COUNTDOWN(m, s, ms)`) |

Almost every screen movie also has `INITIALISE(mc)` and `SET_DISPLAY_CONFIG(_screenWidthPixels, _screenHeightPixels, _safeTopPercent, _safeBottomPercent, _safeLeftPercent, _safeRightPercent, _isWideScreen, _isHiDef, _isAsian)`, which the engine calls itself. The full per-movie list is not reproduced here (it's derived from Rockstar's files); the method above rebuilds it from your own game files in minutes.

**Which movies scripts name, and how.** Of the 511 screen movies:

| How a script gets the movie | Movies |
| --- | ---: |
| Requested by a literal name (`REQUEST_SCALEFORM_MOVIE("countdown")`) | 117 (plus 4 names with no movie in this build: `font_lib_web`, `graphic_design`, `p_bubblegum`, `scaleform_profiling`) |
| Named as a string somewhere else, then requested through a variable (332 such request calls in 179 scripts): the classic heist boards (`heist_agency`, `heist_docks`, `heist_finale`, `heist_jewellery`, `heist_paleto`), `heist_mp`, `island_heist_board`, `auto_shop_board`, `mp_mission_name_freemode`, the shop menus, 32 websites ... | 86 |
| Built from a literal prefix and a number (`mp_car_stats_` 2 to 20, `mp_freemode_checkpoint_` 1 to 10, `player_name_` 1 to 15) | 29 |
| Loaded by the engine, never by a script: the pause menu pages and header, the HUD (`hud`, `hud_cash`, `hud_reticle` ...), `minimap`, fonts, loading screens, `landing_page`, the store, the Rockstar Editor (`new_editor`), the text box | 77 |
| Websites never named in scripts (`appinternet` builds their names) | 56 |
| Never named: phone apps (`app_todo_list`, `app_trackify` ...), phone and laptop screens shown in cutscenes (`ifruit_blank_*`, `badger_*`, `facade_*`, `fam3_*_ncallingmartin`, `rh2a_*_laptop`), dials, mugshot boards (**Known**: drawn as render targets named in the cutscene or prop data, or loaded inside another movie) | 138 |

**The interior maps.** Each `int<number>.gfx` is named after the `joaat` hash of the name scripts pass to `SET_RADAR_AS_INTERIOR_THIS_FRAME` (scripts often write it as `GET_HASH_KEY("v_fakeboatpo1sh1")`). Hashing every string literal in the decompile and the interior names in `frontend.xml` names **221 of the 282** maps (**Verified**); the other 61 belong to names that never appear as a literal. They are not the interior's MLO archetype names: of 519 MLO archetypes in the game's `.ytyp` files, only one shares a hash with a map. By name prefix:

| Prefix | Maps | What (**Known** from the prefix) |
| --- | ---: | --- |
| `v_`, `V_` | 90 | Story-mode interiors and the fake radar spaces (`v_michael`, `v_franklinshouse`, `V_FIB01` to `04`, `V_FakeMetro`, `V_FakePrison`, `v_methlab` ...) |
| `xm_x17dlc_*` | 21 | The Doomsday facility and its tunnels |
| `ex_int_*` | 12 | CEO offices and warehouses |
| `apa_*` | 12 | Executive apartments, stilt houses and the yacht |
| `ch_*`, `vw_*` | 10, 4 | The casino heist areas and the casino, penthouse and garage |
| `m23_*`, `m24_*`, `m25_*`, `xm3_*` | 10, 4, 4, 4 | 2023 to 2025 updates (salvage yard, bail office, hacker garage, car wash ...) |
| `sm_*` | 9 | The Smuggler's Run hangar in each of its layouts |
| `bkr_*` | 8 | Biker clubhouses and businesses |
| `xs_*`, `imp_*`, `h4_*`, `sf_*`, `tr_*`, `ba_*` | 4, 4, 4, 4, 3, 3 | Arena, Import/Export, Cayo Perico (vault, submarine), the agency, Tuners, nightclubs |
| others | 15 | `reh_*`, `po1_08_warehouseint*`, `hei_dlc_garage_*`, `gr_grdlc_*`, `lr_supermod_int`, `dt1_03_carpark`, `cs6_08_mine_int` |

## 22.6 What this means for modders

- **Showing a Rockstar movie from a mod is safe in story mode:** request it, wait until loaded, call its methods, draw it every frame, release it. `mp_big_message_freemode`, `midsized_message`, `instructional_buttons` and `countdown` work the same in story mode.
- **Find a movie's methods in the movie itself:** every method is defined in the `.gfx` with its parameter names ([22.5](#225-every-movie-its-methods-and-who-names-it)); the decompile shows how Rockstar calls them (search for the movie's handle after its `REQUEST_SCALEFORM_MOVIE`).
- **Changing what a movie looks like means editing the `.gfx`** (a Flash file) with a Flash/Scaleform tool and putting the edited copy in the mods folder ([archives and content](/docs/core/archives-and-content.md)). Script calls stay the same as long as the method names do.
- **Draw every frame and release at cleanup:** a movie drawn once shows for one frame; one never released stays in memory.

## 22.7 Open questions

| Question | Where it goes |
| --- | --- |
| The 61 interior maps whose name is not a literal in any script | Next pass: names from the map data (`.ymap` entity names) or the DLC `.ytyp` files |
| Which cutscene or prop draws each of the 138 never-named screen movies | Next pass, with the cutscene files (R5.6) and render-target names |

Answered in the second pass ([22.5](#225-every-movie-its-methods-and-who-names-it)): the movies loaded through variables and the DLC movies, every movie's methods (rebuilt from the `.gfx` files; 712 of the 723 names scripts call are defined), and 221 of the 282 interior maps.

## 22.8 Test cards (story mode, a script mod)

1. **Big message.** Request `mp_big_message_freemode`, call `SHOW_SHARD_WASTED_MP_MESSAGE` with a title and subtitle, and draw it full screen for 3 seconds. Expected: the "WASTED"-style banner with your text.
2. **Buttons.** Request `instructional_buttons`, call `CLEAR_ALL`, `SET_DATA_SLOT` for one control and `DRAW_INSTRUCTIONAL_BUTTONS`. Expected: one button prompt bottom right.
