# Respawn, death and arrest

What happens after "Wasted" or "Busted" in story mode: where the 5 hospitals and 7 police stations are and how they are registered, what `respawn_controller` charges and takes away, what it resets, how missions keep the player from respawning, and how Online's respawn differs. Roadmap topic **R6.2** in the [roadmap](/ROADMAP.md). Builds on [runtime scripts](/docs/core/runtime-scripts.md) (where `respawn_controller` and `standard_global_init` sit), [mission anatomy](/docs/gameplay/missions/mission-anatomy.md) (mission fail and retry) and [native usage](/scripting/native-usage.md). Health, armour and how a ped dies are R3.8.

**How it was made.** Read in the build-3725 decompile (commit `6c18d3e8b`): `standard_global_init` (where the restart points are registered), `respawn_controller` (the respawn sequence, the fee, the arrest penalty, the resets), `main` and `mission_repeat_controller` (switching restart points on and off). Native use from the [MISC](/scripting/native-usage/MISC.md) and [PLAYER](/scripting/native-usage/PLAYER.md) usage pages. Place names come from the respawn animation dictionaries the script loads for each point (`RESPAWN@HOSPITAL@ROCKFORD` ...). Build 1.0.3725.0 Legacy. Script behaviour and numbers are **Verified**; what the engine does between death and the script's turn is **Known** unless stated. Decompiler names (`func_186`, `Global_97607`) are pointers for this build only.

## Short version

- **The engine owns the restart; scripts set the rules.** `standard_global_init` registers 5 hospitals with `ADD_HOSPITAL_RESTART` and 7 police stations with `ADD_POLICE_RESTART` (each called once in the whole game). The engine fades out, moves the player to the nearest enabled point and brings them back; `respawn_controller` dresses the scene and applies penalties.
- **Dying costs 5% of the character's cash, at most $5,000.** The script reads `SPx_TOTAL_CASH`, takes `floor(cash / 100 × 5)`, clamps it to 0 to 5,000 and books it under "money spent on healthcare".
- **Getting busted costs up to $300** ("money spent in cop bribes", the smaller of $300 and your cash) **and clears the character's saved weapon slots:** 44 base-game and 51 DLC weapon entries are zeroed in the save data.
- **A respawn also resets the world around you:** helmet and parachute removed, the weather lock cleared and a random weather picked, the script timecycle modifier cleared, cloud hats unloaded, and a hospital damage pack (`HOSPITAL_0` to `HOSPITAL_9`, bandages and dressings) applied after death.
- **Missions stop the normal restart.** 92 scripts call `PAUSE_DEATH_ARREST_RESTART` and 80 call `IGNORE_NEXT_RESTART` so a death on a mission becomes a mission fail and a retry, not a hospital trip. `main`, `respawn_controller`, `mission_repeat_controller` and `exile_city_denial` switch single restart points off (`DISABLE_HOSPITAL_RESTART`, `DISABLE_POLICE_RESTART`).
- **Online doesn't use the hospitals.** Online scripts search for a spawn point near the player (`NETWORK_START_RESPAWN_SEARCH_FOR_PLAYER` and its result natives, 220 scripts) and bring the player back with `NETWORK_RESURRECT_LOCAL_PLAYER` (263 scripts).

## The restart points

**Verified:** `standard_global_init` registers each point with its coordinates and heading, stores the handle the native returns in a global table (5 hospital slots, 7 police slots), and turns it on with `DISABLE_*_RESTART(handle, false)`. It also sets the defaults every respawn uses: `SET_FADE_OUT_AFTER_DEATH(true)`, `SET_FADE_OUT_AFTER_ARREST(true)`, `SET_FADE_IN_AFTER_DEATH_ARREST(true)`, `PAUSE_DEATH_ARREST_RESTART(false)` and `IGNORE_NEXT_RESTART(false)`.

| Slot | Hospital (respawn animation) | Coordinates | Heading |
| --- | --- | --- | --- |
| 0 | `RESPAWN@HOSPITAL@ROCKFORD` (Mount Zonah, Rockford Hills) | −449.78, −341.40, 33.50 | 83.1 |
| 1 | `RESPAWN@HOSPITAL@SOUTH_CENTRAL` (Central Los Santos, Strawberry) | 341.41, −1396.29, 31.51 | 47.5 |
| 2 | `RESPAWN@HOSPITAL@DOWNTOWN` (Pillbox Hill) | 360.77, −583.43, 27.83 | 276.9 |
| 3 | `RESPAWN@HOSPITAL@SANDY_SHORES` | 1838.50, 3672.22, 33.28 | 206.5 |
| 4 | `RESPAWN@HOSPITAL@PALETO_BAY` | −242.30, 6325.23, 31.43 | 335.2 |

| Slot | Police station (respawn animation) | Coordinates | Heading |
| --- | --- | --- | --- |
| 0 | `RESPAWN@POLICE@VESPUCCI` | −1093.89, −807.08, 18.26 | 42.2 |
| 1 | `RESPAWN@POLICE@SOUTH_CENTRAL_A` (Davis) | 360.88, −1581.61, 28.29 | 23.6 |
| 2 | `RESPAWN@POLICE@DOWN_TOWN` (Mission Row) | 479.64, −976.68, 26.98 | 331.7 |
| 3 | `RESPAWN@POLICE@ROCKFORD` | −560.76, −133.98, 37.06 | 210.6 |
| 4 | `RESPAWN@POLICE@SANDY_SHORES` | 1856.35, 3682.06, 33.27 | 210.2 |
| 5 | `RESPAWN@POLICE@PALETO_BAY` | −440.74, 6019.89, 30.49 | 314.9 |
| 6 | `RESPAWN@POLICE@VINEWOOD` | 639.18, 1.77, 81.79 | 238.0 |

The names in brackets are the usual names for those buildings (**Known**). Each point is also tied to an entry in another global table (a "building" entry) that `standard_global_init` fills alongside; what that table drives (blips, doors, state) is not traced (open question).

**Verified:** to decide which hospital you woke up at, `respawn_controller` measures the distance from where you died to each enabled hospital and takes the nearest. **Known:** the engine uses the same rule to choose where to put you.

## The respawn, step by step

**Verified (`respawn_controller`):**

1. **While you are dead or being arrested** (`IS_PED_INJURED(PLAYER_PED_ID())` or `IS_PLAYER_BEING_ARRESTED`), the script requests the "Wasted" or "Busted" message (`MP_BIG_MESSAGE_FREEMODE` scaleform, labels `RESPAWN_W` and `RESPAWN_B`), the `OFFMISSION_WASTED` audio bank and, for an arrest, the `BUSTED_SCENE` audio scene.
2. **Death or arrest?** It compares `GET_TIME_SINCE_LAST_DEATH` with `GET_TIME_SINCE_LAST_ARREST` (it is the only script that calls either): the more recent one wins.
3. **Back at the hospital or station** it plays a respawn scene: a camera, the character walking out with an injured face (`mood_injured_1` from `facials@P_M_ZERO@BASE` for Michael, and the others' sets), the animation from the table above and the `RESPAWN_SOUNDSET` sounds. After an arrest the help text `AM_H_BUSTED` is shown.
4. **The bill.** After a death: 5% of cash, at most $5,000 (see below). After an arrest: up to $300, and the weapons are taken.
5. **The resets** (next section), then control comes back.

### What it costs

| Event | Charge | Rule | Booked as |
| --- | --- | --- | --- |
| Death | 5% of the character's cash | `floor(cash / 100) × 5`, clamped to 0 to 5,000 | `SPx_MONEY_SPENT_ON_HEALTHCARE` |
| Arrest | The smaller of $300 and your cash | Clamped to 0 to 300 | `SPx_MONEY_SPENT_IN_COP_BRIBES` |

Cash is read from `SP0_TOTAL_CASH`, `SP1_TOTAL_CASH` or `SP2_TOTAL_CASH` (Michael, Franklin, Trevor). The death charge is skipped in two respawn states the script tracks in a global (values 7 and 9; not decoded). Both charges are skipped when the character's money category is 3 or 4 (also not decoded; open question).

### What an arrest takes

**Verified:** after an arrest (and when two exceptions the script checks are both false), `respawn_controller` stores the player's current weapons into the save data, then zeroes one field in each of the character's 44 base weapon entries and 51 DLC weapon entries in that save data, and then runs a helper on the player ped. **Known:** the cleared field is the "owned" state, so the character loses their weapons on arrest, except what a script gives back. Test card 2 checks it.

### What every respawn resets

**Verified** (the function that runs as the respawn starts, in the same code that turns `SET_FADE_OUT_AFTER_DEATH` and `SET_FADE_OUT_AFTER_ARREST` back on):

- Removes the player's helmet (`REMOVE_PED_HELMET`) and parachute pack (`CLEAR_PED_PARACHUTE_PACK_VARIATION`), and resets some outfit parts by character.
- Deletes peds the script tracked for the player.
- Unless a global flag says not to: `CLEAR_WEATHER_TYPE_PERSIST`, `CLEAR_TIMECYCLE_MODIFIER` and `SET_RANDOM_WEATHER_TYPE` (its only caller in the game), then `UNLOAD_ALL_CLOUD_HATS`. So a death rerolls the weather and drops any script screen look.
- After a death, applies one of ten blood-and-bandage damage packs, `HOSPITAL_0` to `HOSPITAL_9` (`APPLY_PED_DAMAGE_PACK`).

## How missions take over

| Native | Scripts | What it does |
| --- | ---: | --- |
| `PAUSE_DEATH_ARREST_RESTART` | 92 | Hold the player dead or arrested until the script says so (mission fail screens, minigames) |
| `IGNORE_NEXT_RESTART` | 80 | Skip the next hospital or station restart: the script will place the player itself |
| `SET_FADE_OUT_AFTER_DEATH` / `_ARREST` | 87 / 82 | Whether the engine fades out after death or arrest |
| `SET_FADE_IN_AFTER_DEATH_ARREST` | 176 | Whether the engine fades back in after the restart |
| `SET_CAM_DEATH_FAIL_EFFECT_STATE` | 91 | The slow-motion grey death effect |
| `DISABLE_HOSPITAL_RESTART` / `DISABLE_POLICE_RESTART` | 6 / 6 | Switch one restart point on or off (`main`, `respawn_controller`, `mission_repeat_controller`, `exile_city_denial`, `standard_global_init`, `standard_global_reg`) |
| `SET_RESTART_COORD_OVERRIDE` / `CLEAR_RESTART_COORD_OVERRIDE` | 1 / 2 | Restart at a given place instead (`animal_controller` for the peyote animal form; `freemode` clears it) |
| `BLOCK_DEATH_JINGLE` | 2 | No "Wasted" music (`main`, `replay_controller`) |

Counts are **Verified**; the "What it does" column is **Known**, from the native names and where they are called.
| `RESET_PLAYER_ARREST_STATE`, `PREVENT_ARREST_STATE_THIS_FRAME` | 262, 88 | Mostly Online interiors and activities (arm wrestling, darts, properties) |

**Verified:** `mission_repeat_controller` turns the restart off for a replayed mission (`PAUSE_DEATH_ARREST_RESTART(true)`, no fade-outs) and back on at the end. `exile_city_denial` switches hospitals and stations on and off. **Known:** it runs during the exile after the FIB missions, when the three can't go back to Los Santos, so you don't respawn in the city. **Known:** on a story mission, the mission script pauses the restart, shows its fail screen and hands over to the replay system ([mission anatomy](/docs/gameplay/missions/mission-anatomy.md)).

## Online

**Verified (counts):** Online scripts handle respawn themselves. They start a search for a safe spawn spot (`NETWORK_START_RESPAWN_SEARCH_FOR_PLAYER` and `NETWORK_START_RESPAWN_SEARCH_IN_ANGLED_AREA_FOR_PLAYER`, 220 scripts), read the results (`NETWORK_QUERY_RESPAWN_RESULTS`, `NETWORK_GET_RESPAWN_RESULT`, `NETWORK_GET_RESPAWN_RESULT_FLAGS`) and revive the player there with `NETWORK_RESURRECT_LOCAL_PLAYER` (263 scripts, 303 calls). Bail is booked through `NETWORK_SPENT_ARREST_BAIL` (8 scripts). On leaving the prologue in a session, `respawn_controller` uses the Online weather override instead of the story lock.

## What this means for modders

- **Don't fight the restart; hook it.** To run code after a respawn, watch for `IS_PLAYER_DEAD` (or `IS_PLAYER_BEING_ARRESTED`) going from true to false and wait until the screen fades in. Re-apply weather, timecycle modifiers, helmets and anything else your mod set: the respawn resets them.
- **Your own respawn point:** `SET_RESTART_COORD_OVERRIDE(x, y, z, heading)` before death and `CLEAR_RESTART_COORD_OVERRIDE` after, or `IGNORE_NEXT_RESTART(true)` with `PAUSE_DEATH_ARREST_RESTART(true)` and place and revive the player yourself (`NETWORK_RESURRECT_LOCAL_PLAYER` also works in story mode, **Known**).
- **Turning hospitals or stations off** works with `DISABLE_HOSPITAL_RESTART(index, true)`, but the index is the handle `ADD_HOSPITAL_RESTART` returned, kept in a story global; adding your own point with `ADD_HOSPITAL_RESTART(coords, heading, 0)` gives you a handle you own. Clean up when your mod stops.
- **Changing the penalties** means editing `respawn_controller`'s behaviour, which mods can't patch cleanly. Refund the cash after the charge (watch `SPx_TOTAL_CASH`), or give weapons back after an arrest.
- **A mod that kills or arrests the player** (a "hardcore" mod, a police mod) should check `GET_MISSION_FLAG` first: on a mission the death becomes a mission fail, not a hospital trip.
- **Single player only.** The Online respawn natives are Rockstar's; don't use mods in GTA Online.

## Open questions

| Question | Where it goes |
| --- | --- |
| What the "building" table tied to each restart point drives | Second pass |
| Which respawn states (global values 7 and 9) and money categories (3 and 4) skip the charges | Second pass: trace the writers of those globals |
| Exactly which weapons survive an arrest | Test card 2 |
| Which of the 10 hospital damage packs is chosen when | Second pass: read the selector in `respawn_controller` |
| Whether the engine picks the nearest enabled point or uses other rules (wanted level, water, the exile) | Test card 3 |

## Test cards

1. **Hospital bill.** As Franklin with $10,000, die anywhere. Expected: you wake at the nearest hospital with $9,500 (5%). With $200,000: $195,000 (the $5,000 cap).
2. **Busted.** As Michael with a full loadout and $1,000, get busted on foot. Expected: $700 left (a $300 charge), and the weapon wheel emptied except what the script gives back. Note exactly what remains.
3. **Nearest point.** Die in the desert halfway between Sandy Shores and Paleto Bay, then near the Vinewood sign. Expected: the nearer hospital each time; after an arrest near the sign, the Vinewood station.
4. **Weather reset.** Lock `THUNDER` with a script, die. Expected: a different weather on respawn.
