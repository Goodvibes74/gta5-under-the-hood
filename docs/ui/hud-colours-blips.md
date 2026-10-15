# HUD, colours and blips

How the HUD is laid out and coloured, and how blips work: the 54 HUD components in `frontend.xml` and which ones scripts hide most, the 235-colour table in `hudcolor.dat`, the blip natives Rockstar's scripts use, the blip sprites they pick, and the radar and minimap. Roadmap topic **R8.4** in the [roadmap](/ROADMAP.md). Builds on [Scaleform movies](/docs/ui/scaleform.md) (R8.2: the minimap and HUD movies) and [pause and Online menus](/docs/ui/pause-menu.md) (R8.1: `frontend.xml` and the map page).

**How it was made.** `update\update.rpf\common\data\ui\frontend.xml` and `hudcolor.dat` of build 1.0.3725.0, extracted with [`tools/rpf-cw.ps1`](/tools/README.md). Every `SET_BLIP_SPRITE` and `HIDE_HUD_COMPONENT_THIS_FRAME` call with a literal value was pulled from the decompile (commit `6c18d3e8b`) with `git grep` and counted. Native counts from [native usage](/scripting/native-usage.md). Values and counts are **Verified**; what a sprite number looks like is **Known** (NativeDB's blip list).

## 24.1 Short version

- **54 HUD components** are placed in `frontend.xml` with position, size, alignment, colour, depth and draw list: `HUD_WANTED_STARS`, `HUD_WEAPON_ICON`, `HUD_CASH`, `HUD_VEHICLE_NAME`, `HUD_AREA_NAME`, `HUD_STREET_NAME`, `HUD_HELP_TEXT`, `HUD_SUBTITLE_TEXT`, `HUD_RADIO_STATIONS_WHEEL`, `HUD_WEAPON_WHEEL`, the Online tags, the replay editor parts and others. Their order is the component number scripts use.
- **Scripts hide components every frame:** `HIDE_HUD_COMPONENT_THIS_FRAME` is in 593 scripts (10,164 calls). The most hidden: 18 (game stream, 1,004 literal calls), 7 (area name, 961), 9 (street name, 850), 8 (unused, 823), 6 (vehicle name, 813), 2 (weapon icon, 793), 10 (help text, 663), 3 (cash, 622), 1 (wanted stars, 584), 15 (subtitles, 541).
- **`hudcolor.dat` defines 235 named colours twice,** for HD (`[HD]`) and for old CRT TVs (`[CRT]`); only 3 differ. Families include 64 `NET_PLAYER` colours, menu, video editor, golf and the characters (`HUD_COLOUR_MICHAEL` 101,180,212; `_FRANKLIN` 171,237,171; `_TREVOR` 255,163,87).
- **Blips are the most-used HUD feature:** `DOES_BLIP_EXIST` (665 scripts, 20,805 calls), `REMOVE_BLIP` (630), `SET_BLIP_SCALE` (539), `SET_BLIP_COLOUR` (531), `SET_BLIP_NAME_FROM_TEXT_FILE` (500, 9,717 calls), `SET_BLIP_ROUTE` (498), `ADD_BLIP_FOR_COORD` (487), `SET_BLIP_PRIORITY` (434), `ADD_BLIP_FOR_ENTITY` (415), `SET_BLIP_SPRITE` (414). The `HUD` namespace has 106 blip natives.
- **191 blip sprites** are set by literal number in 701 calls; the commonest are 66 (77 calls; the "?" marker for a first meeting), 38 (33), 184 (32), 432 and 381 (18 each), 521 (14).
- **Radar and HUD switches:** `DISPLAY_RADAR` (537 scripts), `DISPLAY_HUD` (501), `HIDE_HUD_AND_RADAR_THIS_FRAME` (477), `SET_RADAR_AS_INTERIOR_THIS_FRAME` / `_EXTERIOR_` (266 and 257 scripts) for the interior maps.

## 24.2 HUD components

From `frontend.xml` (**Verified**; component number = position in the list, with `HUD` itself at 0):

| No. | Component | No. | Component |
| ---: | --- | ---: | --- |
| 1 | `HUD_WANTED_STARS` | 11, 12 | `HUD_FLOATING_HELP_TEXT_1`, `_2` |
| 2 | `HUD_WEAPON_ICON` | 13 | `HUD_CASH_CHANGE` |
| 3 | `HUD_CASH` | 14 | `HUD_RETICLE` |
| 4 | `HUD_MP_CASH` | 15 | `HUD_SUBTITLE_TEXT` |
| 5 | `HUD_MP_MESSAGE` | 16 | `HUD_RADIO_STATIONS_WHEEL` |
| 6 | `HUD_VEHICLE_NAME` | 17 | `HUD_SAVING` |
| 7 | `HUD_AREA_NAME` | 18 | `HUD_GAME_STREAM_UNUSED` |
| 8 | `HUD_UNUSED` | 19 | `HUD_WEAPON_WHEEL` |
| 9 | `HUD_STREET_NAME` | 20 | `HUD_WEAPON_WHEEL_STATS` |
| 10 | `HUD_HELP_TEXT` | 21 and up | drug purses, Online tags (`HUD_MP_TAG_*`), `MP_RANK_BAR`, director mode, casino chips, replay editor parts |

Each has `posX`/`posY`, `sizeX`/`sizeY` (fractions of the screen), `alignX`/`alignY`, a `hudcolor`, `alpha`, `depth` and a draw list with priority. Scripts can move one for the frame with `SET_HUD_COMPONENT_POSITION` (269 scripts) and put it back with `RESET_HUD_COMPONENT_VALUES` (299).

**Hidden most** (**Verified**, literal calls): component 18 1,004; 7 961; 9 850; 8 823; 6 813; 2 793; 10 663; 3 622; 1 584; 15 541; 4 519; 13 500; 19 428; 11 293. In practice "hide the corner texts" (area, street, vehicle name) and "hide the weapon icon and cash" for cutscenes and menus.

## 24.3 Colours

`hudcolor.dat` is plain text: a name and RGBA per line, in an `[HD]` and a `[CRT]` section of 235 colours each (**Verified**). Examples from `[HD]`:

| Colour | RGB | Colour | RGB |
| --- | --- | --- | --- |
| `HUD_COLOUR_WHITE` | 240, 240, 240 | `HUD_COLOUR_FREEMODE` | 45, 110, 185 |
| `HUD_COLOUR_RED` | 224, 50, 50 | `HUD_COLOUR_WAYPOINT` | 164, 76, 242 |
| `HUD_COLOUR_BLUE` | 93, 182, 229 | `HUD_COLOUR_GOLD` | 214, 181, 99 |
| `HUD_COLOUR_YELLOW` | 240, 200, 80 | `HUD_COLOUR_MENU_YELLOW` | 240, 160, 0 |
| `HUD_COLOUR_GREEN` | 114, 204, 114 | `HUD_COLOUR_RADAR_HEALTH` | 53, 154, 71 |
| `HUD_COLOUR_ORANGE` | 255, 133, 85 | `HUD_COLOUR_NET_PLAYER1` | 194, 80, 80 |
| `HUD_COLOUR_PURPLE` | 132, 102, 226 | `HUD_COLOUR_MICHAEL` | 101, 180, 212 |
| `HUD_COLOUR_PINK` | 203, 54, 148 | `HUD_COLOUR_TREVOR` | 255, 163, 87 |

Scripts read colours by index with `GET_HUD_COLOUR` (459 scripts, 17,163 calls) and use them for text, markers and scaleform; text labels embed them as `~HUD_COLOUR_GOLD~` ([text labels](/docs/ui/text-labels.md)). `GET_HUD_COLOUR`'s index is the line's position in the table (**Known**).

## 24.4 Blips

| Step | Natives | Scripts |
| --- | --- | ---: |
| Create | `ADD_BLIP_FOR_COORD`, `_FOR_ENTITY`, `_FOR_RADIUS`, `_FOR_PICKUP` | 487, 415, 123, 20 |
| Look | `SET_BLIP_SPRITE`, `SET_BLIP_COLOUR`, `SET_BLIP_SCALE`, `SET_BLIP_ALPHA` | 414, 531, 539, 237 |
| Name | `SET_BLIP_NAME_FROM_TEXT_FILE`, `BEGIN_TEXT_COMMAND_SET_BLIP_NAME` | 500, 315 |
| Behave | `SET_BLIP_ROUTE` (GPS), `SET_BLIP_PRIORITY`, `SET_BLIP_AS_SHORT_RANGE`, `SET_BLIP_FLASH_TIMER`, `SET_BLIP_HIDDEN_ON_LEGEND`, `SET_BLIP_HIGH_DETAIL` | 498, 434, 291, 284, 258, 252 |
| Check and remove | `DOES_BLIP_EXIST`, `REMOVE_BLIP` | 665, 630 |

**Sprites** set by number (**Verified**, 701 literal calls, 191 distinct): 66 (77 calls, the "?" marker; it's also each strangers-and-freaks strand's first blip, [R5.4](/docs/gameplay/missions/strangers-and-freaks.md)), 38 (33), 184 (32), 432 and 381 (18 each; 381 is Barry's strand icon), 521 (14), 225 (12), 480, 385 and 206 (10 each), 425 and 405 (9 each).

Online's creator blips are marked separately (`SET_BLIP_AS_MISSION_CREATOR_BLIP`, 250 scripts) so job content can be told apart from the world's.

## 24.5 Radar and minimap

The radar is the `minimap` Scaleform movie; interiors switch to one of 283 interior map movies (`int<number>.gfx`, [R8.2](/docs/ui/scaleform.md)) when a script calls `SET_RADAR_AS_INTERIOR_THIS_FRAME` (266 scripts), and back with `SET_RADAR_AS_EXTERIOR_THIS_FRAME` (257). `DISPLAY_RADAR` (537 scripts) and `DISPLAY_HUD` (501) turn them off for cutscenes; `IS_RADAR_HIDDEN` (240) checks.

## 24.6 What this means for modders

- **Hide HUD parts every frame** by number (24.2): 6, 7 and 9 together clear the corner texts.
- **Use the named colours** through `GET_HUD_COLOUR` so a mod's UI matches the game; editing `hudcolor.dat` changes them everywhere (a data-file replacement in the mods folder).
- **Always remove the blips you add** and check them with `DOES_BLIP_EXIST`, as Rockstar does in 665 scripts; orphaned blips stay on the map.
- **Moving the radar or a component** for a widescreen or ultrawide layout is a `frontend.xml` edit (positions are fractions of the screen).

## 24.7 Open questions

| Question | Where it goes |
| --- | --- |
| A picture or name for each of the 191 sprites used | Second pass with the blip icon list |
| What the `listId` draw lists and depths do | In-game test |
| The three colours that differ between `[HD]` and `[CRT]` | Second pass |

## 24.8 Test cards (story mode, a script mod)

1. **Components.** Hide components 6, 7 and 9 every tick while driving into a new area. Expected: no vehicle, area or street name in the corner.
2. **Blip.** `ADD_BLIP_FOR_COORD` at a point, `SET_BLIP_SPRITE` 66 and `SET_BLIP_ROUTE` true. Expected: a "?" blip with a GPS line.
