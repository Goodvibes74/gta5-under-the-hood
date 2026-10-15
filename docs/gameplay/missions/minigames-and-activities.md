# Minigames and activities

How story mode's minigames, sports, odd jobs and pastimes are started, scored and paid: the shared launcher that every activity uses, the 19-entry activity list the game keys its stats on, the 42 minigame entries that make up 10% of 100% completion, and what each activity charges or pays, with the exact numbers. Roadmap topic **R5.5** in the [roadmap](/ROADMAP.md). Builds on [strangers, freaks and side content](/docs/gameplay/missions/strangers-and-freaks.md) (R5.4: script brains and launchers), [completion and autosave](/docs/core/completion-and-autosave.md) (R5.3: the completion list) and the [story script catalog](/docs/gameplay/missions/story-script-catalog.md) (R0.1: the 43 minigame and 26 odd-job scripts).

**How it was made.** Read in the build 1.0.3725.0 decompile (commit `6c18d3e8b`): the 16 activity launchers (`launcher_*`, `taxilauncher`, `controller_taxi`, `controller_towing`, `controller_trafficking`, `controller_ambientarea`), the activity scripts themselves (`golf`, `tennis`, `darts`, `yoga`, `triathlonsp`, `pilot_school`, `range_modern`, `offroad_races`, `stunt_plane_races`, `bj`, `hunting_ambient`, `stripclub`, `taxi_procedural`, `towing`, `traffick_air`, `traffick_ground`, `rampage1` to `5`) and `standard_global_reg` (the completion list). Money was found by locating the shared cash function in each script (the one that adds to the character's cash global and writes `spN_total_cash`) and following its wrappers to the calls with literal amounts; each amount was then read in context. Values and counts are **Verified**; who owns which story property, and what players see, are **Known** unless stated.

## 42.1 Short version

- **Every activity starts the same way:** a script brain ([R5.4](/docs/gameplay/missions/strangers-and-freaks.md)) starts a small launcher when the player comes near; the launcher waits within 125 m, shows a help prompt (`PLAY_GOLF`, `PLAY_DARTS`, `PLAY_RANGE` ...) when the player stands within a few metres and nothing blocks it, takes the **mission candidate** slot (one story activity or mission at a time), clears the wanted level and starts the activity with the 64,500-word mission stack.
- **The game numbers its activities 0 to 18:** base jump 0, darts 1, golf 2, hunting 3, off-road races 4, flight school 5, rampages 6, sea races 7, street races 8, strip club 9, stunt planes 10, shooting range 11, taxi 12, tennis 13, towing 14, trafficking air 15, trafficking ground 16, triathlon 17, yoga 18. The launchers report each finished session to telemetry with `PLAYSTATS_ODDJOB_DONE(time, id)`.
- **Minigames are 10% of 100%:** 42 entries (`SC_MG_*`, `SC_MGPS*`), each worth 10/42 %: 12 flight-school lessons, 6 off-road races, 6 shooting-range categories, 5 street races, 4 sea races, 3 triathlons, base jumps and skydives (2), golf, tennis, darts and the strip club. Odd jobs (trafficking, bail bonds, rampages, hunting, taxi) are tracked but worth 0%; yoga is a tracked-only misc entry.
- **Fees:** golf $100 green fee ($200 in one case, free to the golf club's owner), shooting range $14 per session, street races $100 to $1,500 entry, lap dance $40.
- **Pay:** off-road race win $500; tennis $25 × difficulty (×0.5 easy, ×1.5 hard); darts $10 per win counted; taxi $100 per mile plus a 15% or 40% tip for speed; towing $500 (+$50 quick bonus, −$25/$75 for damage); trafficking $5,000 (ground) and $7,000 plus bonuses (air); hunting $5 to $100 a kill times a weapon factor; base jump target landing 30 × a factor.
- **Odd-job money goes through properties:** towing pays into story property 0 and trafficking into property 2, so it reaches whoever owns that business and adds to its earnings stat.
- **The five rampage scripts are one script compiled five times:** they differ only in the rampage number passed in (77 to 81) and a replay label; the kill targets are 25, 20, 30, 30 and 35, with 2 minutes (3 for the military one).
- **Arcade cabinets and casino games are Online only:** the cabinet scripts are started by `am_mp_arc_cab_manager` in the Online arcade; no story script starts them.

## 42.2 The activity list

The ids below are the game's own (they index the completion list, the launchers' stats and `PLAYSTATS_ODDJOB_DONE`) (**Verified**). Completion entries are from `standard_global_reg`; "counts" means the entry is in group 3 (minigames, 10%).

| Id | Activity | Script | Started by | Completion entries |
| ---: | --- | --- | --- | --- |
| 0 | Base jumps and skydives | `bj` (13 jumps, `BJ_JUMP_01` to `13`) | `launcher_BasejumpHeli` (209 m), `launcher_BasejumpPack` (100 m) | `SC_MG_BJUM`, `SC_MG_SKYD` (count) |
| 1 | Darts | `darts` (301 per leg) | `launcher_Darts`, an **object** brain on `prop_dart_bd_01` and `prop_dart_bd_cab_01` (50 m) | `SC_MG_DART` (counts) |
| 2 | Golf | `golf` | `launcher_golf` (209 m) | `SC_MG_GOLF` (counts) |
| 3 | Hunting (free) | `hunting_ambient` | `launcher_Hunting_Ambient` (209 m) | `OJHU` (tracked only) |
| 4 | Off-road races | `offroad_races` | `launcher_OffroadRacing` (209 m) | `SC_MG_OFF1` to `6` (count) |
| 5 | Flight school | `pilot_school` | `launcher_pilotschool` (100 m) | `SC_MGPS1` to `12` (count), `SC_MGPS13` (tracked only) |
| 6 | Rampages | `rampage1` to `5` | `launcher_rampage` (209 m) | `SC_RC_RAM1` to `5` (tracked only) |
| 7 | Sea races | `mission_race` | `launcher_Racing` (209 m) | `SC_MG_SNCA`, `SSC`, `SCAA`, `SCAB` (count) |
| 8 | Street races | `mission_race` | `launcher_Racing` (209 m) | `SC_MG_SRCC`, `SRAP`, `SRFW`, `SRVC`, `SRLS` (count) |
| 9 | Strip club | `stripclub`, `stripclub_drinking`, `stripperhome` | `controller_ambientarea` (at the Vanilla Unicorn) | `SC_MG_STRP` (counts) |
| 10 | Stunt plane time trials | `stunt_plane_races` | `launcher_stunts` (209 m) | `MGSP` (tracked only) |
| 11 | Shooting range | `range_modern` | `launcher_range` (18 m) | `SC_MG_SHHAN`, `SHSUB`, `SHRIF`, `SHLMG`, `SHHVY`, `SHSHO` (count) |
| 12 | Taxi jobs | `taxi_procedural` and 9 scripted fares (`taxi_*`) | `controller_taxi` | `OJTX1` to `10` (tracked only) |
| 13 | Tennis | `tennis`, plus `tennis_family` and `tennis_ambient` | `launcher_tennis` (100 m) | `SC_MG_TENN` (counts) |
| 14 | Towing | `towing` | `controller_towing` | none |
| 15 | Trafficking (air) | `traffick_air` | `controller_trafficking` | `OJDA1` to `5` (tracked only); the bail bond entries `SC_OJBB*` reuse id 15 |
| 16 | Trafficking (ground) | `traffick_ground` | `controller_trafficking` | `OJDG1` to `20` (tracked only) |
| 17 | Triathlon | `triathlonsp` | `launcher_Triathlon` (100 m) | `SC_MG_TRI1` to `3` (count) |
| 18 | Yoga | `yoga` | `launcher_Yoga` (20 m) | `SC_MSC_YOG` (misc, tracked only) |

**Not in the list:** the cinema (`act_cinema`, its own world-point brain, `SC_MSC_CIN` counts as misc), the pier rides (`bigwheel`, `rollercoaster`, from `fairgroundHub`), the cable car, the car wash, photography (`photographymonkey`, `photographywildlife`) and friend activities (`friendactivity`: bar, cinema, darts, strip club count as `SC_FR_*` in the 5% friends group; golf and tennis with friends are tracked only).

**Online only** (never started in story mode): `golf_mp`, `tennis_network_mp`, `pilot_school_mp`, `range_modern_mp`, `stripclub_mp`, the casino games (`casinoroulette`, `blackjack`, `three_card_poker`) and the arcade cabinets. The cabinet games are started by Online's `am_mp_arc_cab_manager` and the arcade props scripts, and five of the nine register as network scripts (**Verified**).

## 42.3 The shared launcher

All twelve `launcher_*` scripts for activities (base jumps, darts, golf, free hunting, off-road, flight school, range, stunts, tennis, triathlon, yoga) are built from one template; only the setup function differs (**Verified**, read in `launcher_darts` and `launcher_golf`, confirmed by the same strings in the others):

1. **Set-up.** Writes the activity script name (`"Darts"`, `"golf"`, `"Pilot_School"`, `"range_modern"`, `"TriathlonSP"` ...), the activity id (table above), the leave radius (125 m; yoga 20 m, stunts 209 m, golf the blip's radius + 5 m), the prompt radius (4 m by default; darts and yoga 2.5 m, the range and hunting 2 m, golf 7 m, stunts 6 m) and the help text. The stack is set to **64,500** (the mission stack) for every activity.
2. **Wait.** Exits if a network session is running (`NETWORK_IS_IN_SESSION`), if another copy is running, or if the player walks out of the leave radius.
3. **Load.** Requests the models it needs (darts: the opponent model and `prop_dart_1`).
4. **Prompt.** While the player is inside the prompt radius, in the right interior, in control (`IS_PLAYER_CONTROL_ON`, `IS_PLAYER_SCRIPT_CONTROL_ON`), allowed to start a mission (`CAN_PLAYER_START_MISSION`), not switching characters and not in another activity, it holds input 51 (context) exclusive and shows the help text. Golf shows `PAY_PLAY_GOLF` instead of `PLAY_GOLF` when the green fee applies.
5. **Start.** On the press it requests the script, takes control away and asks for the **mission candidate** slot. The candidate system (shared globals, up to 8 requests in a frame) lets only one story mission or activity run; the winner sends `FORCE_CLEANUP(8)` so ambient scripts that listen for it tidy up. If the launcher gets the slot it clears the wanted level, gives control back and starts the script.
6. **Watch.** While the activity runs it records mission checkpoints (`PLAYSTATS_MISSION_CHECKPOINT`); when it ends it reports `PLAYSTATS_ODDJOB_DONE(milliseconds, id)` and terminates.

`launcher_racing` (street and sea races) works the same way but starts `mission_Race` itself and charges the entry fee first (42.4). `launcher_rampage` also starts `mission_stat_watcher` (1,828). The taxi, towing and trafficking controllers run all the time from `initial` and start their job scripts when the job is offered ([runtime scripts](/docs/core/runtime-scripts.md)).

## 42.4 Fees and pay

All story money goes through one shared function compiled into each script: it takes the character, credit or debit, a reason number and an amount, updates the cash global, `spN_total_cash` and the earned or spent stats (**Verified**). Amounts found:

| Activity | Money | Rule (**Verified** unless marked) |
| --- | --- | --- |
| Golf | −$100 or −$200 | Green fee, $200 when one flag is set (*probably* playing with a partner); skipped when the current character owns story property 8 (the golf club, **Known**) |
| Shooting range | −$14 | Charged once when a session starts, even if the player can't afford it |
| Street races | −$100, −$500, −$1,000, −$1,250, −$1,500 | Entry fee for the five street races; the four sea races are free |
| Strip club | −$40 | A lap dance (`stripclub` sets the price to 40) |
| Cinema | −$20 per person | `act_cinema` charges 20 × the number of tickets |
| Off-road races | +$500 | Paid for finishing first, once (a "paid" bit is checked) |
| Tennis | +$25 × difficulty | ×0.5 easy, ×1 normal, ×1.5 hard, rounded down ($12, $25, $37); when the opponent is a story character the same amount also goes through their account (*probably* they pay it) |
| Darts | +$10 per win | 10 × the player's win counter at the end of a match (that it counts legs is *probable*) |
| Base jumps | +floor(30 × factor) | When the player lands within 10 m of the target or close to its line |
| Taxi | +fare, + tip | Fare = ceil(miles × 100), so $100 a mile (distance in metres × 0.000621); tip 40% of the fare if the average speed was over 40 mph, 15% over 30 mph, else none |
| Towing | +$500, +$50, −$25 / −$75 | $500 per job, +$50 if finished within 12 s of a check, minus damage deductions (`TOW_DMG_01`: $25 at damage 250, $25 or $75 at 500 and 900); nothing if the job failed |
| Trafficking (ground) | +$5,000 | Per job (`DTRSHRD_MONEY`) |
| Trafficking (air) | +$7,000 + bonuses | $7,000 plus three bonus fields from the run |
| Hunting | +score × weapon factor | Per kill, below; paid to Trevor when the session ends |

**Odd-job pay is property income.** Towing pays through a function that credits the owner of story property 0 and adds to its earnings; trafficking does the same for property 2 (**Verified**). These are the towing yard (Franklin) and the airfield hangar (Trevor) (**Known**), so the money lands with whoever owns the business, not with whoever happens to be playing.

**Hunting score** (**Verified**, `hunting_ambient`). Each kill stores a `hunt_score` and `hunt_weapon` decorator on the animal; the pay is the kill's points × the weapon group's factor, rounded:

| Kill | Points | | Weapon group | Factor |
| --- | ---: | --- | --- | ---: |
| Heart shot (torso bones) | 100 | | Sniper, rifle, pistol | 1 |
| Neck | 75 | | SMG | 0.75 |
| Head, legs and other hits | 50 | | Melee and other | 0.5 |
| Boar | 50 | | Shotgun, machine gun | 0.25 |
| A doe (decorator `doe_elk`) | 25 | | Heavy, thrown | 0.1 |
| Mountain lion | 25 | | | |
| Coyote | 10 | | | |
| Run over by a car | 5 | | | |

## 42.5 Scoring

| Activity | How it is scored (**Verified** from the scripts' labels and values) |
| --- | --- |
| Shooting range | Points per hit (`SHR_1PT`, `3PT`, `5PT`, `7PT`) in challenges per weapon category (`SHR_CAT_HG`, `SMG`, `AR`, `SG`, `LMG`, `HVY`, plus `RAILGUN`); bronze, silver and gold goals (`SHR_M_BRONZE` ... `SHR_M_GOLD`) |
| Flight school | 13 lessons with bronze, silver and gold; the lesson bars (`PS_BAR_LOOP`, `ROLL`, `IMMEL`, `KNIFE`, `INVERT`) and failure reasons (`PS_FAIL_1` to `19`) |
| Darts | 301 down per leg, both players start at 301 |
| Rampages | Kill a target number within the time: 25 (Rampage 1, rednecks), 20 (hipsters), 30 (Vagos), 30 (Ballas), 35 (soldiers, grenade launcher), 2 minutes each except the soldiers' 3 |
| Hunting | Points per kill (42.4) |
| Races, triathlons, stunts | Position or time, with the race UI from the shared `SP_SPR` text |
| Golf, tennis | Strokes and points, with the leaderboards read from Rockstar's servers when online (`LEADERBOARDS2_READ_*`) |

The mission-passed style result screen with a medal (`mission_complete` Scaleform, `SET_MEDAL`) is drawn by `minigame_stats_tracker`; no script in this build starts it by name (open question).

**Text blocks** each activity loads (`REQUEST_ADDITIONAL_TEXT`): `SP_GOLF`, `TENNIS`, `DARTS`, `YOGA`, `SP_SPR` (off-road, stunts, triathlon), `PSCHOOL`, `S_RANGE`, `BJUMP`, `AMBHT` (hunting), `TAXI`, `DTRSHRD` plus `DTRFAIR` or `DTRFKGR` (trafficking).

## 42.6 The rampages

The five rampage scripts are the same code (57,868 lines each); `diff` shows only two lines changed: the rampage number passed to the set-up (77, 81, 78, 79, 80 for scripts 1 to 5) and the replay event label (**Verified**). The set-up switch holds each rampage's data:

| Number | Script | Targets | Weapons given | Kills | Time |
| ---: | --- | --- | --- | ---: | --- |
| 77 | `rampage1` | Rednecks (`a_m_m_hillbilly_01`, `a_m_y_salton_01`), Sandy Shores | Assault rifle, pistol | 25 | 2 min |
| 81 | `rampage2` | Hipsters (`a_m_y_hipster_01` to `03`) | Sawn-off shotgun, pistol, bat | 20 | 2 min |
| 78 | `rampage3` | Vagos (`g_m_y_mexgoon_03`, `a_m_y_mexthug_01`) | Micro SMG, pistol, assault rifle | 30 | 2 min |
| 79 | `rampage4` | Ballas (`g_m_y_ballaeast_01`, `ballaorig_01`) | Assault rifle, pistol | 30 | 2 min |
| 80 | `rampage5` | Soldiers (`s_m_y_marine_01`, `crusader`), Zancudo | Grenade launcher, assault rifle | 35 | 3 min (default) |

Each also sets its intro and outro animations, enemy vehicles, ambient speech, a music event (`RAMPAGE_n_OS`) and an audio scene (`RAMPAGE_REDNECKS_SCENE` ...).

## 42.7 What this means for modders

- **To add an activity, copy the launcher pattern:** a world-point or object brain, a small launcher that checks conditions and shows a prompt, then the real script. In a mod (C#, Lua, C++) a proximity check plus `IS_CONTROL_JUST_PRESSED(0, 51)` does the same job; check `GET_MISSION_FLAG` and `CAN_PLAYER_START_MISSION` so you don't start during a mission.
- **Don't start activity scripts yourself without the launcher's set-up.** They expect the candidate slot, the wanted level cleared and the launcher's arguments (base jump and darts take a struct of arguments); started bare they may fail or not clean up.
- **To change pay, change the money, not the script:** in a mod, award money on the same events (a race finish, a tow) by reading the stat or the event yourself. The amounts in 42.4 are compiled into the scripts, so editing them means patching bytecode.
- **Completion is by entry, not by script.** Finishing an activity sets its entry in the completion list; a mod that replaces an activity loses that 10/42 % unless it sets the same entry.
- **Odd-job money reaches the business owner.** If you build a new business, pay through property earnings the same way, or the money will look wrong in the property stats.
- Online versions (`*_mp`) need `freemode`; they are reference only. Never run mods in GTA Online.

## 42.8 Open questions

| Question | Where it goes |
| --- | --- |
| Who starts `minigame_stats_tracker` and `minigame_ending_stinger` (not started by name in this build) | Next pass: search by hash |
| The flight-school, range and triathlon medal thresholds | Next pass: read each script's goal tables |
| Golf: course data, AI foursome behaviour, how the score is kept | Next pass |
| How the flow unlocks each activity (blips appear after story missions) | Next pass, with [story flow](/docs/gameplay/missions/story-flow.md) |
| The sea-race labels (`SNCA`, `SSC`, `SCAA`, `SCAB`) and street-race labels in English | Text files ([R8.3](/ROADMAP.md)) |
| The towing quick-bonus check (what the 12 s timer measures) | Next pass |

## 42.9 Test cards

1. **Range fee.** Note your cash, start a shooting-range session at Ammu-Nation (Pillbox Hill or Cypress Flats) and quit. Expected: $14 less.
2. **Taxi tip.** Do a procedural taxi fare driving fast and another driving slowly. Expected: a tip of 40% of the fare for the fast one, none for the slow one.
3. **Hunting factor.** With Trevor, kill one elk with a heart shot using the sniper rifle and one with a shotgun. Expected: $100 and $25.
