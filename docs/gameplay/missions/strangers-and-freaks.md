# Strangers, freaks and side content

How story mode's side content appears in the world: the "script brains" that start a script when the player comes near a world point or an object, the 32 launcher scripts, the 63-entry table of strangers-and-freaks missions (18 strands) with their positions, blips, time windows and follow-up scripts, and the controller that decides which ones are available. Roadmap topic **R5.4** in the [roadmap](/ROADMAP.md). Builds on the [story and shared script catalog](/docs/gameplay/missions/story-script-catalog.md) (R0.1: the 88 strangers-and-freaks scripts), [story flow](/docs/gameplay/missions/story-flow.md) (R5.1) and [mission anatomy](/docs/gameplay/missions/mission-anatomy.md) (R5.2).

**How it was made.** Read in the build 1.0.3725.0 decompile (commit `6c18d3e8b`): `standard_global_init` (every brain registration), `randomchar_controller` (6,388 lines), and the table-filling function that is shared by many scripts. The table was parsed from its 63 calls; brain registrations were listed with `grep`. Counts and values are **Verified**. Where the world points themselves are placed (map data) and what a brain's activation range means are **Known**.

## 20.1 Short version

- **Side content starts from brains.** `standard_global_init` registers **99 world-point brains** and **47 object brains** (`REGISTER_WORLD_POINT_SCRIPT_BRAIN`, `REGISTER_OBJECT_SCRIPT_BRAIN`). When the player comes within range of a point (or of an object with a listed model), the engine starts the script.
- **What the brains start:** 31 `launcher_*` scripts (one per strand or activity), 35 random events (`re_*`), 14 street characters (`gpb_*`), collectables and secrets (`flyUnderBridges`, `underwaterPickups`, `UFO`, `murderMystery`, `ShopRobberies`, `altruist_cult`), `savegame_bed`, and object scripts such as `atm_trigger` (8 ATM models), `ob_tv` (6 TV models), vending machines and drinks.
- **32 launcher scripts exist;** 31 are world-point brains and `launcher_Darts` is an object brain (2 dartboard models). The launcher checks the conditions and starts the real mission.
- **The strangers-and-freaks table has 63 entries in 18 strands:** Epsilon 8, Nigel 7, Barry 6, Paparazzo 6, Rampage 5, Tonya 5, Extreme 4, Josh 4, Fanatic 3, Minute 3, Abigail 2, Hunting 2, Mrs Philips 2, Omega 2, Dreyfuss 1, Hao 1, Maude 1, The Last One 1.
- **Each entry has** a script name, a strand, a position, a blip sprite (66, the "?" marker, for each strand's first meeting), an optional help text, a follow-up script, and an hour window: 55 are available all day (0 to 23:59), 6 from 07:00 to 20:00 (Fanatic 1 to 3, Nigel 1B to 1D), Barry 4 from 08:00 to 20:00, and Hao 1 only at night (20:00 to 05:00).
- **`randomchar_controller`** loops over the 63 entries (one per frame slot), checks which can be shown, and manages 40 doors with `DOOR_SYSTEM_SET_DOOR_STATE` for the strands' locations.

## 20.2 Script brains

`standard_global_init` registers every brain once at start-up (**Verified**).

**World-point brains** (99): name, activation range in metres, and a flag. Ranges used: 209 m (28 brains), 150 m (25), 200 m (16), 100 m (16), 180 m (2), and single brains at 80, 50, 40 (`savegame_bed`), 3 and 0.5 m.

| Group | Brains |
| --- | ---: |
| `launcher_*` (strands and activities) | 31 |
| `re_*` random events | 35 |
| `gpb_*` street characters (Andy Moon, Baygor, Bill Binder, Clinton, Griff, Jane, Jerome, Jesse, Mani, the Mime, Pamela Drake, Superhero, Tonya, Zombie) | 14 |
| Secrets and collectables: `flyUnderBridges`, `underwaterPickups`, `UFO`, `murderMystery`, `ShopRobberies`, `altruist_cult`, `chop`, `fairgroundHub`, `act_cinema`, `wp_PartyBoomBox` | 10 |
| Homes: `savegame_bed`, `ob_sofa_franklin`, `ob_sofa_michael`, `ob_franklin_tv`, `ob_mp_bed_low`, `_med` | 6 |
| Online leftovers: `AM_MP_CARWASH_LAUNCH`, `AM_MP_GARAGE_CONTROL`, `AM_MP_PROPERTY_EXT` | 3 |

**Object brains** (47): name, model, a percentage, range and flags. Examples: `atm_trigger` on 8 ATM models (4 m), `ob_tv` on 6 TV models (10 to 25 m), `laptop_trigger` (5 models), `ob_drinking_shots` (3), `ob_vend1` and `ob_vend2` (vending machines), `ob_telescope` (4), `ob_mp_bed_high` (4), `launcher_Darts` (2), and single props such as `ob_bong`, `ob_wheatgrass`, `ob_mr_raspberry_jam`, `ob_airdancer`, `ob_foundry_cauldron`.

*Known*: a world-point brain is tied to world points placed in the map data with the script's name; the brain starts its script when the player is within the range of one of them and the script ends itself when the player leaves. Scripts check `IS_WORLD_POINT_WITHIN_BRAIN_ACTIVATION_RANGE` (80 scripts) to know when to quit. Whole groups can be switched off with `DISABLE_SCRIPT_BRAIN_SET` / `ENABLE_SCRIPT_BRAIN_SET` (4 and 5 scripts), which missions do to keep side content away.

## 20.3 The strangers-and-freaks table

The same table-filling function is compiled into many scripts (every story mission, `randomchar_controller`, the ambient scripts), so all of them agree on each entry. Per strand (**Verified**):

| Strand | Entries | Notes |
| --- | ---: | --- |
| Epsilon | 8 | Follow-up scripts `epsCars`, `epsRobes`, `epsDesert`, `epsilonTract`, `postRC_Epsilon4` |
| Nigel | 7 | `Nigel1A` to `1D` are the celebrity item hunts (help `NIGITEMS`) |
| Barry | 6 | `Barry3A` and `3C` are the stash hunts (help `BARSTASH`); `Barry4` 08:00 to 20:00 |
| Paparazzo | 6 | `Paparazzo3A`, `3B` (help `PAPPHOTO`) |
| Rampage | 5 | Run by `rampage_controller` |
| Tonya | 5 | Follow-ups `ambient_Tonya`, `ambient_TonyaCall`; two entries have no fixed position |
| Extreme | 4 | |
| Josh | 4 | Follow-up `forSaleSigns` |
| Fanatic | 3 | 07:00 to 20:00 |
| Minute | 3 | |
| Abigail | 2 | Follow-up `ambient_Diving` (submarine parts) |
| Hunting | 2 | |
| Mrs Philips | 2 | `ambient_MrsPhilips`; the second has no fixed position |
| Omega | 2 | Follow-up `spaceshipParts` |
| Dreyfuss | 1 | Help `LETTERS_HINT` (the letter scraps) |
| Hao | 1 | 20:00 to 05:00 |
| Maude | 1 | Follow-up `BailBond_Launcher` |
| The Last One | 1 | |

**The blips** (**Verified** sprite numbers): the first meeting of each strand uses sprite 66 (the "?" marker); later ones use the strand's own icon (206 Epsilon, 381 Barry, 149 Nigel, 389 Paparazzo, 84 Rampage, 388 Tonya, 382 Extreme, 385 Josh, 405 Fanatic, 386 Minute, 387 Omega, 384 Hunting).

## 20.4 The controller

`randomchar_controller` (**Verified**, entry function):

1. Ends itself on force cleanup or when a story switch is set.
2. Fills the table, then loops: each frame it advances a slot counter (modulo 60) and walks the 63 entries, checking whether each can be offered (flow state, character, time window) and whether its script or follow-up is running (`GET_NUMBER_OF_THREADS_RUNNING_THE_SCRIPT_WITH_THIS_HASH`, 21 calls).
3. Keeps 40 doors of the strands' locations locked or open (`DOOR_SYSTEM_SET_DOOR_STATE`, 40 calls; models such as `v_ilev_gc_door04`, `v_ilev_ta_door`, `prop_ron_door_01`).

The missions themselves are started by the launchers, not by the controller (no `START_NEW_SCRIPT` in it).

## 20.5 What this means for modders

- **To add a side mission that appears in the world,** a mod can't register a new world point brain into the map data easily; the simple way is a script that watches the player's distance to a point and starts its own mission, as the brains do.
- **To keep side content out of a mod's scene,** do what missions do: `DISABLE_SCRIPT_BRAIN_SET` and re-enable it at cleanup.
- **The table in 20.3 is the place to read where and when** a stranger appears; its values are compiled into every story script, so don't patch one script and expect the others to agree.
- **Object brains are easy hooks:** any prop with one of the listed models (ATMs, TVs, vending machines) runs its script when you come near, also when a mod places that prop.

## 20.6 Open questions

| Question | Where it goes |
| --- | --- |
| The unlock condition of each entry (flow flags, character) from the remaining table fields | Second pass |
| Where the world points are placed and how many there are per brain | Map data, R4.6 second pass |
| What the object-brain percentage and flags mean | Second pass, in-game test |

## 20.7 Test cards

1. **Brain range.** In story mode with a trainer, teleport 250 m from Barry's start point, then 150 m. Expected: `launcher_Barry` is not running at 250 m and is at 150 m (inside 209 m).
2. **Object brain.** Spawn `prop_atm_01` next to the player. Expected: `atm_trigger` starts.
