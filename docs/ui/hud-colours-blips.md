# HUD, colours and blips

How the HUD is laid out and coloured, and how blips work: the 54 HUD components in `frontend.xml` and which ones scripts hide most, the 235-colour table in `hudcolor.dat`, the blip natives Rockstar's scripts use, the blip sprites they pick, and the radar and minimap. Roadmap topic **R8.4** in the [roadmap](/ROADMAP.md). Builds on [Scaleform movies](/docs/ui/scaleform.md) (R8.2: the minimap and HUD movies) and [pause and Online menus](/docs/ui/pause-menu.md) (R8.1: `frontend.xml` and the map page).

**How it was made.** `update\update.rpf\common\data\ui\frontend.xml` and `hudcolor.dat` of build 1.0.3725.0, extracted with [`tools/rpf-cw.ps1`](/tools/README.md). Every `SET_BLIP_SPRITE` and `HIDE_HUD_COMPONENT_THIS_FRAME` call with a literal value was pulled from the decompile (commit `6c18d3e8b`) with `git grep` and counted. Native counts from [native usage](/scripting/native-usage.md). Values and counts are **Verified**; what a sprite number looks like is **Known** (NativeDB's blip list).

## 24.1 Short version

- **54 HUD components** are placed in `frontend.xml` with position, size, alignment, colour, depth and draw list: `HUD_WANTED_STARS`, `HUD_WEAPON_ICON`, `HUD_CASH`, `HUD_VEHICLE_NAME`, `HUD_AREA_NAME`, `HUD_STREET_NAME`, `HUD_HELP_TEXT`, `HUD_SUBTITLE_TEXT`, `HUD_RADIO_STATIONS_WHEEL`, `HUD_WEAPON_WHEEL`, the Online tags, the replay editor parts and others. Their order is the component number scripts use.
- **Scripts hide components every frame:** `HIDE_HUD_COMPONENT_THIS_FRAME` is in 593 scripts (10,164 calls). The most hidden: 18 (game stream, 1,004 literal calls), 7 (area name, 961), 9 (street name, 850), 8 (unused, 823), 6 (vehicle name, 813), 2 (weapon icon, 793), 10 (help text, 663), 3 (cash, 622), 1 (wanted stars, 584), 15 (subtitles, 541).
- **`hudcolor.dat` defines 235 named colours twice,** for HD (`[HD]`) and for old CRT TVs (`[CRT]`); only 3 differ. Families include 64 `NET_PLAYER` colours, menu, video editor, golf and the characters (`HUD_COLOUR_MICHAEL` 101,180,212; `_FRANKLIN` 171,237,171; `_TREVOR` 255,163,87).
- **Blips are the most-used HUD feature:** `DOES_BLIP_EXIST` (665 scripts, 20,805 calls), `REMOVE_BLIP` (630), `SET_BLIP_SCALE` (539), `SET_BLIP_COLOUR` (531), `SET_BLIP_NAME_FROM_TEXT_FILE` (500, 9,717 calls), `SET_BLIP_ROUTE` (498), `ADD_BLIP_FOR_COORD` (487), `SET_BLIP_PRIORITY` (434), `ADD_BLIP_FOR_ENTITY` (415), `SET_BLIP_SPRITE` (414). The `HUD` namespace has 106 blip natives.
- **191 blip sprites** are set by literal number in 701 calls; the commonest are 66 (77 calls; the "?" marker for a first meeting), 38 (33), 184 (32), 432 and 381 (18 each), 521 (14).
- **Each sprite has a name label** `BLIP_<number>` in `global.gxt2` (945 of them): 66 is "Strangers and Freaks", 38 "Finish Line", 184 "Camera", 381 "Barry", 521 "Laptop"; six are left as "Temp_1" to "Temp_6" (second pass, [24.4](#244-blips)). Only three colours differ between `[HD]` and `[CRT]`, the video editor fade-outs ([24.3](#243-colours)).
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

*Second pass (2026-10-25, **Verified**):* the two sections differ in exactly three colours, the video editor's fade-out colours. In `[HD]` they are darker copies of their base colours (`HUD_COLOUR_VIDEO_EDITOR_AUDIO_FADEOUT` 59, 34, 57 next to `_AUDIO` 162, 79, 157; `_TEXT_FADEOUT` 41, 68, 53; `_SCORE_FADEOUT` 82, 58, 10); in `[CRT]` they equal the base colours, so on a CRT the editor's clips don't darken when they fade. 23 of the 235 entries hold no RGBA of their own but name another colour (`HUD_COLOUR_PICKUP` → `HUD_COLOUR_GREEN`, `HUD_COLOUR_PAUSE_SINGLEPLAYER` → `HUD_COLOUR_GREEN`, `HUD_COLOUR_RADAR_ARMOUR` → `HUD_COLOUR_BLUE` ...), so changing a base colour also changes its links. The base copy in `common.rpf` has 180 colours per section; the update added the other 55 at the end, as the file's header asks ("only ever at the end"), so a colour's index never moves.

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

**What each sprite is** (*second pass, 2026-10-25*). `global.gxt2` has a label `BLIP_<number>` for 945 sprite numbers up to 958; its text is the sprite's name, the one the pause map's legend shows for a blip that has no name of its own (the text is **Verified**; that the legend uses it is **Known**). All 191 sprites scripts set by number have one. Six are placeholders named "Temp_1" to "Temp_6" (429 to 434; 432 alone is set 18 times). By hundreds, with the number of literal calls in brackets:

| Sprites | Names (calls) |
| --- | --- |
| 0 to 99 | 6 Player (4), 15 Police Helicopter (1), 16 Police Plane (1), 38 Finish Line (33), 40 Safehouse (3), 47 Snitch (1), 50 Criminal Carsteal (1), 52 Criminal Holdups (2), 63 Elevator (2), 64 Helicopter (6), 66 Strangers and Freaks (77), 67 Armored Van (3), 68 Tow Truck (1), 72 Los Santos Customs (4), 73 Clothes Store (2), 76 Simeon (1), 77 Lester (5), 78 Michael (2), 79 Trevor (3), 84 Rampage (2), 85 Vinewood Tours (1), 88 Franklin (3) |
| 100 to 199 | 100 Car Wash (2), 106 FIB (1), 108 Devin (3), 109 Golf (1), 110 Ammu-Nation (1), 119 Shooting Range (1), 121 Strip Club (2), 134 Criminal Cuff Keys (1), 135 Movie Theater (3), 136 Music Venue (1), 140 Stash (1), 143 Objective (1), 146 Objective (1), 149 Nigel (9), 152 Grenade (1), 184 Camera (32), 198 Cab (2) |
| 200 to 299 | 206 Epsilon (10), 225 Gang Vehicle (12), 266 Fairground (2), 267 Property Management (1), 269 Altruist (9), 270 Enemy (8), 272 Cash Pickup (2), 273 Chop (1), 274 Dead (3), 280 Friend (1), 293 Simeon Family (2) |
| 300 to 399 | 306 Crate Drop (4), 307 Plane Drop (1), 308 Sub (1), 326 Getaway Car (6), 348 Gang Bike (9), 350 Property For Sale (2), 351 Gang Attack Package (2), 352 Martin Madrazo (1), 353 Enemy Helicopter (4), 356 Marina (1), 357 Garage (7), 358 Golf Flag (2), 359 Hangar (1), 362 Masks Store (3), 369 Garage For Sale (1), 377 Parachute (2), 381 Barry (18), 382 Dom (9), 385 Josh (10), 386 Minute (9), 389 Paparazzo (9), 398 Creator (6), 399 Creator Direction (6) |
| 400 to 499 | 400 Abigail (9), 402 Repair (1), 403 Raging (1), 405 Fanatic (9), 406 Invisible (1), 408 Capture (2), 410 Boat (1), 411 Capture (4), 419 Capture (1), 421 Tank (1), 422 Heli (3), 423 Plane (2), 425 Player (9), 427 Boat (6), 428 Heist (3), 429 Temp_1 (2), 430 Temp_2 (2), 431 Temp_3 (2), 432 Temp_4 (18), 433 Temp_5 (2), 434 Temp_6 (3), 438 King of the Castle (1), 440 Dead Drop (5), 441 Penned In (1), 442 Beast (4), 443 Cross The Line Pointer (6), 446 Benny's (3), 455 Yacht (3), 456 Finders Keepers (6), 457 Hostile Takeover Package (1), 458 Executive Search (4), 459 Sightseer (1), 461 Asset Recovery (2), 471 Seashark (1), 472 Dark (1), 475 Office (3), 477 Truck (3), 478 Special Cargo (6), 479 Trailer (2), 480 VIP (10), 481 Cargobob (2), 486 Bomb (3), 492 Biker Clubhouse (3), 493 Caged In (1), 494 Turf War (1), 495 Joust (1), 496 Weed Production (3) |
| 500 to 599 | 512 Quad Bike (1), 521 Laptop (14), 525 Registration Papers (3), 527 Junkyard (1), 528 Phantom Wedge (1), 530 Ruiner 2000 (1), 531 Ramp Buggy (2), 533 Rocket Voltic (1), 534 Technical Aqua (1), 535 Target A (4), 536 Target B (4), 537 Target C (4), 538 Target D (4), 539 Target E (4), 540 Target F (4), 543 Juggernaut (3), 544 Repair (5), 556 Weapon Supplies (3), 564 Mobile Operations Center (2), 566 Bunker Vehicle Workshop (1), 567 Weapon Workshop (5), 568 Cargo (1), 570 Transform Checkpoint (6), 587 Treasure (4), 588 Orbital Cannon (1) |
| 600 to 699 | 604 CCTV (1), 606 Turret Station (5), 620 Hack Target (3), 627 Drone (5), 628 Cash Register (1), 630 Target (1), 632 Terrorbyte (2), 641 Arena Series (1), 645 Arena Turret (6), 647 RC Workshop (1), 648 Fire Pit (3), 661 Deathbike (2), 671 Hardcore Comic Store (1), 673 RC Bandito Time Trials (1), 674 King Of The Hill (4), 676 Rucksack (1), 677 Shipping Container (1), 679 Casino (2), 682 Concierge (1) |
| 700 to 799 | 724 Limo (1), 738 Gerald (1), 745 Winky (1), 760 Kosatka (2), 766 Beach Party (1), 781 Prize Car (1), 789 Bounty Collectibles (1), 790 Movie Collectibles (2), 795 Train (2) |
| 800 to 899 | 817 Payphone (1), 820 Jubilee (1), 827 Biker Bar (1), 829 Junk Energy Skydive (1), 830 Luxury Autos (1), 837 Clubhouse Contract (1), 838 Agent ULP (1), 840 Acid Lab (3), 842 Dead Drop (1), 859 Bicycle (3), 860 Junk Energy Time Trial (1), 863 Ready for sell Overlay (1), 871 Vincent (1) |
| 900 to 999 | 902 Darnell Bros Garment Factory Equipment (1), 915 Fast Travel (1), 918 Collectible (1), 939 Prix Luxury Real Estate (1), 943 Fire Truck (1) |

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
| What the `listId` draw lists and depths do | Partly answered in [pause menu 23.6](/docs/ui/pause-menu.md#236-frontendxml-where-the-hud-and-menus-sit) (list 1 is the top-right stack, ordered by `listPriority`); test card 2 there confirms it |
| A picture of each sprite (the names are in 24.4) | Second pass: the radar icons in the `minimap` movie, or in-game screenshots |

Answered in the second pass: a name for each of the 191 sprites used ([24.4](#244-blips)) and the three colours that differ between `[HD]` and `[CRT]` ([24.3](#243-colours)).

## 24.8 Test cards (story mode, a script mod)

1. **Components.** Hide components 6, 7 and 9 every tick while driving into a new area. Expected: no vehicle, area or street name in the corner.
2. **Blip.** `ADD_BLIP_FOR_COORD` at a point, `SET_BLIP_SPRITE` 66 and `SET_BLIP_ROUTE` true. Expected: a "?" blip with a GPS line.
