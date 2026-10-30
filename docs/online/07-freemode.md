# Inside `freemode` (first pass)

What the GTA Online main script does: how it starts, its two state machines, the order of its per-frame work, the roughly 180 systems it runs, the scripts it launches, the events it answers, and the globals and tunables it lives on. Roadmap topic **R7.1** in the [roadmap](/ROADMAP.md). It builds on [guide 1](/docs/online/01-how-online-works.md) (how Online works) and guide 4 (why `freemode` can't simply run offline).

**How it was made.** Read from the build-3725 decompile of `freemode` (1,470,129 lines, 25,748 functions) and `freemode_init`. Because Rockstar's function names are compiled out, each system in 7.4 was **identified by what it touches**: a small tool walked the call graph from each function `freemode` calls in its main state and listed the strings (models, labels, script names, stats) reachable from it, skipping shared helpers. The labels in 7.4 are ours, read from those strings; the call order and counts are **Verified**. Global and function names are the decompiler's and change between builds.

## 7.1 Short version

- **`maintransition` picks `freemode` as the script to run** when the player enters a GTA Online session; `freemode_init` runs first to set up a few globals and the cloud time.
- **Start-up** requests `FMMC_Launcher` (the job lobby) and `freemode_clearGlobals`, registers `freemode` as a network script with 32 participants, starts `FMMC_Launcher`, sets fixed positions (apartment views), configures audio, suppresses ambient props, and reads dozens of stats and tunables into the player's broadcast data.
- **The main loop runs two state machines each frame:**
  - **The player state** (one value per player, in that player's broadcast data): 0 start, 11 and 10 joining, 2 placing the player, **4 running**, 5 leaving.
  - **The host state** (in the server broadcast data, only on the session host): 0 start, **4 running**, 5 ending. While running, the host updates about 25 shared systems.
- **The running state calls about 180 systems in a fixed order** every frame: HUD cash, clothing and outfit checks, personal vehicles, properties and the spawn location, businesses and their safes, the phone, apps and text messages, DLC story flows (one per update since 2017), freemode events, deliveries, pickups, drones, the yacht, the Kosatka, and the interaction menu.
- **It launches 29 helper scripts**, from `am_pi_menu` (interaction menu) and the business apps to the yacht, the Kosatka island trip and `sctv` (spectator TV).
- **It answers events:** 60 network event types, and 381 kinds of player-to-player **script events**, each with its own tunable kill switch.
- **It lives on globals and tunables.** It refers to the tunables block (`Global_262145`) 31,290 times, across 17,829 different fields, more than anything else; the player broadcast data (`Global_1845250`, 880 values per player; `Global_2658291`, 468 per player) and the server broadcast data (`Global_2649159`) carry the state every other Online script reads.

## 7.2 Start-up

In order (**Verified**, `__EntryFunction__`):

1. Request `FMMC_Launcher`, one more script chosen by a helper, and `freemode_clearGlobals`; reset several globals.
2. `NETWORK_SET_THIS_SCRIPT_IS_NETWORK_SCRIPT(32, ...)`: from here `freemode` is a network script with up to 32 participants, which is why it can't run without a session.
3. Store the property interior id if no property interior script is running.
4. Start `FMMC_Launcher` with a 28,000 stack (the job lobby, R7.5).
5. Allow this script to remove any script's blips; fill a small table of fixed camera and building positions (the high-rise apartments' views).
6. Configure audio (`OnlyAllowScriptTriggerPoliceScanner`), GPS, and suppress ambient snack, drink and cigarette props.
7. Turn off about 40 world features by index unless the player is in the matching one (a check against `Global_1845093`).
8. Hide the HUD, reactivate the world brains for property exteriors, garages, car washes and the cinema (`AM_MP_PROPERTY_EXT`, `AM_MP_GARAGE_CONTROL`, `AM_MP_CARWASH_LAUNCH`, `ACT_CINEMA`).
9. Read stats and tunables into the player's broadcast data (`Global_1845250[player].f_260...`): owned properties, unlocks, preferences, cooldowns.

`freemode_init` (15,102 lines) runs before it: it stamps the cloud time into `Global_1989168`, picks the last-used vehicle slot, and turns vehicle generators back on near the casino.

## 7.3 The main loop

Each frame (**Verified**):

1. A few always-run functions: timers, the staggered player loop, event processing (7.6), and a check that can trigger a re-sync.
2. **Player state** switch on `Global_2658291[player]`:

| State | Function | What it does |
| --- | --- | --- |
| 0 | Start | Wait until the host's state is above 0, turn off infinite ammo, go to 11 |
| 11 | Joining | Go to 10 |
| 10 | Joining (143 lines) | Wait for the session and the player's data |
| 2 | Placing | Freeze the player until the spawn area's collision is loaded, then the set-up function (293 lines) and go to 4 |
| **4** | **Running** | The 180 systems of 7.4 |
| 5 | Leaving | Clean-up |

3. **Host state**, only when this machine is the host (`Global_2673271.f_4.f_4`): switch on `Global_2649159`: 0 start, **4 running** (about 25 functions that keep shared state: the session's businesses, freemode events, deliveries, a rotation through the participants one per frame), 5 nothing.

So every player's `freemode` runs the same per-player systems, and one of them, the host, also runs the shared ones.

## 7.4 The systems it runs

The running state calls 183 functions. Grouped by what they reach (our labels from their strings; examples are the strings found):

| Group | Examples found | What it is |
| --- | --- | --- |
| Money and HUD | `SET_MULTIPLAYER_HUD_CASH` from the wallet balance; `GOODBOYTICK`, `service_earn_not_badsport` | Cash display, bad-sport and good-boy timers |
| Clothing and appearance | `CLO_*`, `dlc_mp_*_berd_*`, `MP_Heist4_Tee_*` | Checking owned outfits and items per DLC |
| Weapons and loadout | Mk II components, `weapon_*` | Owned weapons, ammo, components |
| Personal vehicles and garages | `Not_Allow_As_Saved_Veh`, `PA_DELIVERY_*`, vehicle model lists | Saved vehicles, Mechanic delivery, insurance |
| Special vehicles | `deluxo`, `oppressor2`, `kosatka`, `avenger`, `terrorbyte` (`Player_Hacker_Truck`), countermeasures (`flares_released`, `chaff_cooldown`) | Owned special vehicles and their weapons |
| Properties and spawning | `MP_SETTING_SPAWN_PRIVATE_YACHT`, `_CLUBHOUSE`, `PROPERTY_OFFICE_1_GARAGE_LVL2`, `SIMPLE_INTERIOR_ARMORY_AIRCRAFT_1` | Spawn location, property list, simple interiors |
| Business safes | `ARCADE_PAY`, `SALV_PAY`, `BO_PAY`, `HDEN_PAY`, `CWASH_PAY`, `BusinessHeatCarWash` | Daily income and safe limits for the arcade, salvage yard, bail office, hands-on car wash and others |
| Business apps | `appbikerbusiness`, `appimportexport`, `appsecuroserv`, `appInternet`, `WWW_WARSTOCK_D_CACHE_D_AND_D_CARRY_COM` | Launching the computer apps |
| DLC story flows | `CH_FLOW_*` (Casino Heist), `HIF_*` (Cayo Perico), `TFLOW_*` (Tuners), `FIX_FLOW_*` (The Contract), `SUM22_*`, `XM22_*` (Criminal Enterprises, Los Santos Drug Wars), `SALV23_*`, `HK24_FLW_*` | One function per update that drives its intro calls, help text and unlocks |
| Contact and phone | `TXTMSG`, `CELL_*`, `Phone_SoundSet_*`, `AVI_INVITE_NM`, payphone sounds | Text messages, calls, invites |
| Freemode events and jobs | `GB_CONTRABAND_DEFEND`, `GB_VELOCITY`, `fm_content_armoured_truck`, `fm_content_robbery`, `Public_Mission_Controller`, `am_lester_cut` | Starting and tracking organisation work and freemode content |
| Deliveries | `FREEMODE_DELIVERY_DEBUG_PRINT_DELIVERABLE_ID`, `FM_DEL_UNS_*` | The shared delivery system (business sell missions) |
| Pickups and collectibles | `pickup_money_*`, `ccur_collectible_reward`, signal jammers (`SIGJAM*`), `GUN_VAN` | Money drops, collectibles, the Gun Van |
| Prizes | `SPIN_THE_WHEEL`, `Prize_*` | Arena War spin wheel |
| Crew and social | `mpply_crew_*`, `crew_logo` | Crew data |
| Drones and RC | `am_mp_drone`, `rcbandito`, `ArenaEMP` | Nano drone, RC Bandito, EMP |
| Yacht, Kosatka, bunker, facility | `PYV_Yacht`, `Player_Moon_Pool`, `gr_prop_gr_bunkeddoor`, `xm_prop_x17_osphatch_col` | Owned bases and their doors |
| Interaction menu | `PIM_*` | Quick options |
| Transitions | `TRANSITION_STATE_*`, `maintransition` | Watching for job and session changes |

A few of these entries reach more than 1,000 functions each (clothing, weapons, properties), which is why `freemode` is the biggest script in the game.

## 7.5 Scripts it launches

From the launch graph ([`reference/Script-Launch-Graph.md`](/scripting/script-launch-graph.md), **Verified**), with stack sizes: `fmmc_launcher` (28,000), `freemode_clearglobals` (14,100), `am_pi_menu` (9,800, interaction menu), `sctv` (8,344), `am_mp_island` (15,900, Cayo Perico), `missioniaaturret` (15,900), `am_mp_yacht` (5,000), `am_mp_arena_box` (5,050), `am_penthouse_peds` (5,050), `heli_gun` (5,050), `appbikerbusiness`, `appimportexport`, `appinternet`, `appsecuroserv` (4,592 each), `am_mp_smpl_interior_int` (2,512), `gb_ie_delivery_cutscene` (2,324), `net_cloud_mission_loader` (2,050), and at 1,424: `am_mp_drone`, `am_mp_orbital_cannon`, `am_mp_rc_vehicle`, `am_mp_smpl_interior_ext`, `cellphone_flashhand`, `emergencycalllauncher`, `fake_interiors`, `fm_maintain_cloud_header_data`, `sclub_front_bouncer`, `spawn_activities`, `vehicle_stealth_mode`; plus `gb_biker_target_rival` (512). The many freemode events (`am_*`, `fm_content_*`, `gb_*`) are started through script launchers and the host, not by direct name, so they don't appear in this list.

## 7.6 Events

`freemode` reads both event queues each frame (**Verified**):

- **Network events** (queue 1): a switch over 60 event types (ids 151 to 249 in this build), including player joined and left, entity damage, and the one that carries script events.
- **Script events**: one handler (3,083 lines) with **381 cases**, one per event hash. Each case first checks a flag in `Global_1690406` and returns if it is set, so Rockstar can switch any single event off through tunables. These are how players' scripts tell each other things (invites, bounties, business raids, "give cash", "join my organisation"). It is also the attack surface known from modding Online, which is why the switches exist.

## 7.7 Globals it lives on

Most referenced globals in `freemode` (**Verified** counts; roles are our reading):

| Global | References | Role |
| --- | --- | --- |
| `Global_262145` | 31,290 (17,829 distinct fields) | **Tunables**: Rockstar's server-side switches and prices ([guide 1](/docs/online/01-how-online-works.md)) |
| `Global_2733002` | 5,923 | Freemode local state |
| `Global_1845250[player]` | 4,436 | **Player broadcast data**, 880 values per player (properties, vehicles, status) |
| `Global_2673271` | 3,593 | Local session state (includes "am I host") |
| `Global_1950198` | 3,414 | |
| `Global_2635562` | 3,273 | |
| `Global_2658291[player]` | 3,244 | **Player broadcast data**, 468 values per player; value 0 is the player state |
| `Global_2649159` | 276 | **Server broadcast data**; value 0 is the host state |
| `Global_4718592` | 1,173 | |

It also calls `GET_NETWORK_TIME` 633 times, `NETWORK_IS_ACTIVITY_SESSION` 621 times (job sessions run a reduced `freemode`), `GET_CLOUD_TIME_AS_INT` 298 times (daily timers), and `NET_TO_VEH` / `NET_TO_PED` 673 times (networked entity handles). Mapping these blocks is roadmap topic R0.4.

## 7.8 What this means for modders

- **We can't run `freemode`, but we now know its shape.** An offline Online mode can copy the architecture: a per-player state machine (start, place, run, leave), a host state for shared systems, and a fixed per-frame order of independent systems. Each of the 7.4 groups becomes a module.
- **Most systems are local in effect.** Clothing, weapons, vehicles, properties, safes, phone and story flows read stats and tunables and act on the local player. Offline, they need a local save and fixed tunable values, not a network.
- **Tunables are the main dependency.** 17,829 tunable fields are read; an offline build needs a defaults table for the ones its systems use (R7.3).
- **Script events become direct calls.** Offline there are no other players, so the 381 script events reduce to the few that the game sends to itself (invites, deliveries); our modules can call each other directly.
- **The order matters for performance.** `freemode` spreads player work over frames (one participant per frame on the host). Mods on low-end PCs should do the same instead of looping over everything every frame.

## 7.9 Open questions

| Question | Where it goes |
| --- | --- |
| What each of the 183 running-state functions does in detail (this pass labels them from strings only) | R7.1 second pass, per system |
| Names of the 60 network event ids and the main script event hashes | R7.2, R15 |
| The fields of the player and server broadcast data | R0.4 global map |
| What `freemode_clearGlobals` resets and when | R7.2 |
| How the host's rotation through participants works | Mostly answered (second pass): `freemode` has 47 separate counters, each visiting one of the 32 player slots per frame and wrapping to 0 (a full pass every 32 frames). The host's work uses the same pattern; which counter belongs to the host state was not pinned |
