# Script catalog: story mode and shared scripts

The 584 scripts in `script_rel.rpf` (plus the two Pilot School copies in `x64w.rpf`) that the Online catalog ([online guide 2](/docs/online/02-script-catalog.md)) left in one group, "story mode, shared systems and test scripts", broken down into 12 groups with one line per script. Roadmap topic R0.1 (the [roadmap](/ROADMAP.md)).

**How it was made.** The script list and sizes come from the build-3725 decompile, which matches the game files of that build byte for byte. Each script was placed by its name and, where the name wasn't clear, by the strings and natives in its decompiled code. **Verified:** the list, the sizes, the empty scripts, the script-brain registrations in section 1.3. **Known:** most mission titles and what each mission is about come from general knowledge of the game; lines marked "to check" are guesses that need a closer read.

**Size** is the size of the decompiled source, not the bytecode size used in the Online catalog. It is a rough weight only: every script compiles in the shared header code it uses (clothing tables, door and property code, menus), so a small script that uses a big shared header can look large. `missioniaaturret` and `puzzle` are examples: most of their 8 MB is shared Online property and door code.

## 1.1 Overview

| Group | Scripts | Size | What it is |
| --- | --- | --- | --- |
| [Story systems and controllers](#story-systems-and-controllers-66-scripts) | 66 | 76 MB | The scripts that run story mode: mission flow and triggers, character switching, respawn, saves, phone calls and emails, completion, wardrobes, start-up and registration |
| [Story missions and support](#story-missions-and-their-support-scripts-108-scripts) | 108 | 177 MB | Every main story mission, heist setups, preps and finales, the endings, Lester's assassinations, therapy sessions, family events, safehouse intros |
| [Strangers and freaks](#strangers-and-freaks-88-scripts) | 88 | 71 MB | Side characters (Barry, Epsilon, Nigel, Tonya, Maude ...), rampages, the Altruist Cult, and the "after" scripts that run when one finishes |
| [Random events](#random-events-38-scripts) | 38 | 8 MB | The `re_` world events and the controller that starts the area-based ones |
| [Minigames, sports and activities](#minigames-sports-and-activities-43-scripts) | 43 | 61 MB | Golf, tennis, darts, yoga, triathlon, flight school, shooting range, races, base jumps, the pier rides, strip club, casino table games (several in story and Online versions) |
| [Odd jobs and street scenes](#odd-jobs-and-street-scenes-26-scripts) | 26 | 6 MB | Taxi, towing, Trevor's trafficking, street performers |
| [Collectibles and easter eggs](#collectibles-and-easter-eggs-9-scripts) | 9 | 0.4 MB | Letter scraps, spaceship parts, underwater items, UFOs, the blimp |
| [Launchers](#launchers-37-scripts) | 37 | 8 MB | Small scripts tied to a world point that start a side mission or activity when the player comes near |
| [World objects and ambient world](#world-objects-and-the-ambient-world-41-scripts) | 41 | 27 MB | `ob_` scripts tied to props (vending machines, TVs, beds, cash registers), ATMs, restricted areas, animals, Chop, club patrons |
| [Arcade, hacking and gun cameras](#arcade-games-hacking-minigames-and-gun-cameras-15-scripts) | 15 | 29 MB | Arcade cabinets, the 2024 hacking minigames, turret and gunner cameras, two large Online scripts to check |
| [Cut prototypes](#cut-prototypes-5-scripts) | 5 | 0.4 MB | `pm_` free-roam job prototypes that never shipped as content |
| [Debug, test and empty](#debug-test-and-empty-scripts-108-scripts) | 108 | 0.2 MB | Rockstar's test tools; 86 of them are empty in release |

## 1.2 What stands out

- **86 scripts are empty in release** (an entry function with no code). They are debug and test tools Rockstar compiled out: `aicover_test`, `combat_test`, `cutscene_test`, the `gtest_*` AI tests, `navmeshtest`, `scriptplayground`, `streaming` and others. A few more are near-empty, such as `custom_config` (exits at once) and `mpstatsinit` (fills a table of award stats and exits). **Verified.**
- **Online-only scripts sit in this group too:** `golf_mp`, `tennis_network_mp`, `pilot_school_mp`, `range_modern_mp`, `stripclub_mp`, `wardrobe_mp`, the casino table games, the arcade cabinets and the 2024 hacking minigames. They landed here because their names have no Online prefix. **Verified** from their strings.
- **The two wardrobe scripts are the largest in the group** (about 10 MB each decompiled), because they carry the full clothing tables for every character. They are the place to read how outfits are listed and applied (roadmap R6.3, items 9 and 10).
- **Most missions are 1 to 3.5 MB of decompiled code.** The biggest are the finales (`finale_heist2a` and `2b`, the Bureau Raid finales), `martin1`, `fbi5a`, `fbi2` and `exile2`.

## 1.3 How these scripts get started

**Verified** from the decompile:

- **`standard_global_init` registers 146 script brains:** 99 with `REGISTER_WORLD_POINT_SCRIPT_BRAIN` and 47 with `REGISTER_OBJECT_SCRIPT_BRAIN`. A world-point brain ties a script name to world points placed in the map data, so the engine starts the script when the player is near that point. That is how the launchers work: `launcher_golf` is registered as a world-point brain with an activation range of 209. An object brain ties a script to a prop model: `ob_vend1` is registered for the soda machine models (`prop_vend_soda_01` and others) with a range of 10, so walking up to any of those machines starts the vending script.
- **Brain sets are switched on and off** with `ENABLE_SCRIPT_BRAIN_SET` (10 calls in all scripts) and `DISABLE_SCRIPT_BRAIN_SET` (18 calls), which is how whole families of scripts can be paused, for example during missions.
- **`initial` starts `flow_controller` and `randomchar_controller`.** `main` also checks for `randomchar_controller` and for several launchers, and starts them itself when none is running: before starting `launcher_golf` it checks `GET_NUMBER_OF_THREADS_RUNNING_THE_SCRIPT_WITH_THIS_HASH`.
- **Random events name each other:** every `re_` script references the others, which fits a shared rule that only one random event runs at a time (to check in R4.4).

The full launch graph (who starts whom, with stack sizes) is roadmap topic R0.5: first pass in [engine guide 1](/docs/core/runtime-scripts.md) and the generated [launch graph](/scripting/script-launch-graph.md).

## 1.4 Every script, by group

Sorted by size, largest first.

### Story systems and controllers (66 scripts)

| Script | Size | What it does |
| --- | --- | --- |
| `wardrobe_mp` | 10.4 MB | Wardrobe in Online properties |
| `wardrobe_sp` | 10.3 MB | Safehouse wardrobe |
| `director_mode` | 3.6 MB | Director mode |
| `tuneables_processing` | 3.2 MB | Processes tunables |
| `flow_controller` | 2.6 MB | The story mission flow: strands, unlocks, flags |
| `mission_repeat_controller` | 2.6 MB | Replaying a finished mission from the pause menu |
| `mission_triggerer_b` | 2.4 MB | Mission triggers, group B |
| `family_scene_m` | 2.4 MB | Michael's family at home |
| `mission_triggerer_c` | 2.3 MB | Mission triggers, group C |
| `mission_triggerer_d` | 2.3 MB | Mission triggers, group D |
| `mission_triggerer_a` | 2.2 MB | Mission triggers, group A |
| `family_scene_t0` | 2.2 MB | Trevor's home scene 0 |
| `family_scene_t1` | 2.2 MB | Trevor's home scene 1 |
| `replay_controller` | 2.2 MB | Rockstar Editor recording |
| `family_scene_f0` | 2.2 MB | Franklin's home scene 0 |
| `selector` | 2.1 MB | The character wheel and switching |
| `benchmark` | 2.0 MB | The built-in benchmark run (graphics settings menu) |
| `pi_menu` | 1.9 MB | Story-mode interaction menu |
| `initial` | 1.9 MB | First script of a new game: sets up the player characters |
| `spawn_activities` | 1.9 MB | What the player is doing on spawn (sleeping, smoking, in a property) |
| `respawn_controller` | 1.9 MB | Death, arrest, hospital and police station respawn |
| `save_anywhere` | 1.8 MB | Quick save from the phone |
| `savegame_bed` | 1.8 MB | Saving in a safehouse bed |
| `autosave_controller` | 1.8 MB | Autosave |
| `sp_menuped` | 1.7 MB | Story menu ped (character preview) |
| `vehrob_planning` | 917 KB | Online vehicle robbery planning menu (car list) |
| `friends_controller` | 769 KB | Friends: calls and hanging out |
| `completionpercentage_controller` | 570 KB | The 100% completion tracker |
| `achievement_controller` | 374 KB | Achievements |
| `mission_stat_watcher` | 281 KB | Mission stats for the medals (time, accuracy, headshots) |
| `comms_controller` | 276 KB | Calls, texts and emails sent by the story (a queue) |
| `timershud` | 257 KB | Timers on the HUD |
| `email_controller` | 202 KB | Emails |
| `standard_global_init` | 194 KB | Initialises the global variables |
| `stock_controller` | 142 KB | Story stock market (LCN and BAWSAQ) |
| `randomchar_controller` | 133 KB | Which strangers and freaks are available |
| `event_controller` | 72 KB | Phone and event notifications, including Online event invites |
| `cheat_controller` | 67 KB | Cheat codes |
| `family_scene_f1` | 63 KB | Franklin's home scene 1 |
| `pickup_controller` | 53 KB | Weapon, health and armour pickups in the world |
| `blip_controller` | 44 KB | Story blips |
| `shrinkletter` | 37 KB | Dr. Friedlander's letter |
| `bootycallhandler` | 37 KB | Booty calls |
| `charactergoals` | 27 KB | Per-character goals |
| `lesterhandler` | 23 KB | Lester's house and laptop |
| `flow_help` | 14 KB | Help messages queued by the flow |
| `emergencycall` | 11 KB | 911 calls |
| `minigame_stats_tracker` | 10 KB | Minigame stats |
| `candidate_controller` | 10 KB | Candidate selection helper (empty body, to check) |
| `tasklist_1` | 8 KB | Phone side-task list |
| `vehiclespawning` | 7 KB | Story vehicle spawns |
| `floating_help_controller` | 4 KB | Floating help text |
| `flowintrotitle` | 3 KB | The opening title and logo |
| `flowstartaccept` | 3 KB | "Press to continue" screen at the start |
| `main_install` | 3 KB | Prologue installer: loads the North Yankton map |
| `title_update_registration` | 3 KB | Registers title update content |
| `minigame_ending_stinger` | 2 KB | Short music stinger after a minigame |
| `rng_output` | 1 KB | Random number helper (tiny) |
| `mpstatsinit` | 1 KB | Fills the table of Online award stats, then exits |
| `title_update_registration_2` | 1 KB | Registers title update content, part 2 |
| `mission_stat_alerter` | < 1 KB | Mission stat alerts (tiny) |
| `landing_pre_startup` | < 1 KB | Runs before startup (tiny) |
| `sp_dlc_registration` | < 1 KB | Registers story-mode DLC save data |
| `sp_pilotschool_reg` | < 1 KB | Registers the flight school DLC |
| `custom_config` | < 1 KB | Exits at once |
| `sc_lb_global_block` | < 1 KB | Sets leaderboard globals, then exits |

### Story missions and their support scripts (108 scripts)

| Script | Size | What it does |
| --- | --- | --- |
| `finale_heist2a` | 3.5 MB | The Big Score, subtle approach |
| `finale_heist2b` | 3.3 MB | The Big Score, obvious approach |
| `martin1` | 3.2 MB | Martin Madrazo strand mission |
| `fbi5a` | 3.2 MB | FIB strand: Monkey Business |
| `agency_heist3a` | 3.2 MB | The Bureau Raid finale, fire crew approach |
| `agency_heist3b` | 3.2 MB | The Bureau Raid finale, roof approach |
| `fbi2` | 3.1 MB | FIB strand: Three's Company |
| `exile2` | 3.1 MB | Exile strand: Predator |
| `jewelry_heist` | 3.0 MB | The Jewel Store Job finale |
| `fbi4` | 3.0 MB | FIB strand: Blitz Play |
| `family6` | 3.0 MB | Family strand: Reuniting the Family |
| `trevor1` | 2.9 MB | Trevor strand: Mr. Philips |
| `trevor2` | 2.9 MB | Trevor strand mission 2 |
| `carsteal2` | 2.9 MB | Devin Weston car thefts, mission 2 |
| `carsteal1` | 2.9 MB | Devin Weston car thefts, mission 1 |
| `finale_heist1` | 2.9 MB | Big Score: setup |
| `franklin1` | 2.9 MB | Franklin strand: Hood Safari |
| `michael2` | 2.9 MB | Michael strand: Fresh Meat |
| `docks_heista` | 2.8 MB | The Merryweather Heist, offshore approach |
| `rural_bank_heist` | 2.8 MB | The Paleto Score finale |
| `docks_setup` | 2.8 MB | Merryweather Heist: Scouting the Port |
| `fbi3` | 2.8 MB | FIB strand: By the Book |
| `finalec2` | 2.8 MB | Ending C: the third way, part 2 |
| `exile3` | 2.8 MB | Exile strand: Derailed |
| `docks_heistb` | 2.8 MB | The Merryweather Heist, freighter approach |
| `armenian1` | 2.7 MB | Simeon strand: Franklin and Lamar |
| `family3` | 2.7 MB | Family strand: Marriage Counseling |
| `family4` | 2.7 MB | Family strand: Fame or Shame |
| `franklin2` | 2.6 MB | Franklin strand: Lamar Down |
| `family1` | 2.6 MB | Michael's family strand: Father/Son |
| `carsteal4` | 2.6 MB | Devin Weston car thefts, mission 4 |
| `franklin0` | 2.6 MB | Franklin strand: Chop |
| `michael1` | 2.6 MB | Michael strand: Bury the Hatchet |
| `armenian3` | 2.6 MB | Simeon strand: Complications (Franklin meets Michael) |
| `exile1` | 2.6 MB | Exile strand: Minor Turbulence |
| `prologue1` | 2.6 MB | Prologue: the North Yankton robbery, the game's first mission |
| `lester1` | 2.6 MB | Lester strand: Friend Request |
| `michael3` | 2.6 MB | Michael strand: The Wrap Up |
| `michael4` | 2.5 MB | Michael strand: Meltdown |
| `family5` | 2.5 MB | Family strand: Did Somebody Say Yoga? |
| `fbi1` | 2.5 MB | FIB strand: Dead Man Walking |
| `chinese1` | 2.5 MB | Trevor strand: Wei Cheng and the O'Neil brothers, part 1 |
| `finalec1` | 2.5 MB | Ending C: the third way, part 1 |
| `carsteal3` | 2.5 MB | Devin Weston car thefts, mission 3 |
| `rural_bank_setup` | 2.4 MB | Paleto Score: setup |
| `finale_endgame` | 2.4 MB | After the ending: sets the world up for free roam |
| `agency_heist1` | 2.3 MB | Bureau Raid: setup mission 1 |
| `finalea` | 2.3 MB | Ending A: kill Trevor |
| `agency_heist2` | 2.3 MB | Bureau Raid: setup mission 2 |
| `solomon1` | 2.3 MB | Solomon strand: Mr. Richards |
| `finale_heist_prepd` | 2.3 MB | Big Score prep D |
| `finaleb` | 2.2 MB | Ending B: kill Michael |
| `jewelry_setup1` | 2.2 MB | Jewel store heist: Casing the Jewel Store |
| `trevor4` | 2.2 MB | Trevor strand mission 4 |
| `fbi4_intro` | 2.0 MB | Blitz Play: intro |
| `jewelry_prep1b` | 1.9 MB | Jewel store heist prep (B) |
| `lamar1` | 1.8 MB | Franklin strand: The Long Stretch |
| `fbi4_prep3` | 1.7 MB | Blitz Play prep 3 |
| `armenian2` | 1.5 MB | Simeon strand: Repossession |
| `trevor3` | 1.4 MB | Trevor strand mission 3 |
| `family2` | 1.2 MB | Family strand: Daddy's Little Girl |
| `me_tracey1` | 993 KB | Michael's family event: Tracey |
| `me_amanda1` | 952 KB | Michael's family event: Amanda |
| `me_jimmy1` | 946 KB | Michael's family event: Jimmy |
| `solomon2` | 880 KB | Solomon strand: The Ballad of Rocco |
| `chinese2` | 801 KB | Trevor strand: Wei Cheng and the O'Neil brothers, part 2 |
| `finale_heist_prepc` | 778 KB | Big Score prep C |
| `fbi4_prep2` | 738 KB | Blitz Play prep 2 |
| `solomon3` | 724 KB | Solomon strand mission 3 |
| `finale_heist_prepa` | 671 KB | Big Score prep A |
| `fbi4_prep5` | 652 KB | Blitz Play prep 5 |
| `fbi4_prep4` | 647 KB | Blitz Play prep 4 |
| `michael4leadout` | 638 KB | Lead-out scene after Meltdown |
| `drf1` | 589 KB | Dr. Friedlander therapy session 1 |
| `drf2` | 589 KB | Dr. Friedlander therapy session 2 |
| `drf5` | 589 KB | Dr. Friedlander therapy session 5 |
| `sh_intro_m_home` | 588 KB | Intro of Michael's house as a safehouse |
| `assassin_bus` | 584 KB | Lester assassination: The Bus Assassination |
| `finale_intro` | 581 KB | Big Score: intro |
| `assassin_valet` | 559 KB | Lester assassination: The Hotel Assassination |
| `assassin_multi` | 553 KB | Lester assassination: The Multi Target Assassination |
| `assassin_hooker` | 543 KB | Lester assassination: The Vice Assassination |
| `assassin_construction` | 541 KB | Lester assassination: The Construction Assassination |
| `sh_intro_f_hills` | 526 KB | Franklin moving into his Vinewood Hills safehouse |
| `docks_prep1` | 457 KB | Merryweather Heist prep (offshore approach) |
| `rural_bank_prep1` | 452 KB | Paleto Score: prep (military hardware) |
| `jewelry_prep2a` | 377 KB | Jewel store heist prep (2A) |
| `jewelry_prep1a` | 374 KB | Jewel store heist prep (A) |
| `docks_prep2b` | 361 KB | Merryweather Heist prep (freighter approach) |
| `finale_heist_prepb` | 294 KB | Big Score prep B |
| `fbi4_prep1` | 266 KB | Blitz Play prep 1 |
| `agency_prep2amb` | 211 KB | Bureau Raid prep, ambient version |
| `fbi4_prep3amb` | 206 KB | Blitz Play prep 3, ambient version (found in the world) |
| `finale_heist_prepeamb` | 195 KB | Big Score prep E, ambient version |
| `drf3` | 106 KB | Dr. Friedlander therapy session 3 |
| `drf4` | 106 KB | Dr. Friedlander therapy session 4 |
| `agency_prep1` | 98 KB | Bureau Raid prep: the fire truck |
| `finale_credits` | 81 KB | The end credits |
| `finale_choice` | 30 KB | The ending choice (kill Trevor, kill Michael, or the third way) |
| `exile_city_denial` | 25 KB | Keeps the player out of the city while the story is in exile |
| `af_intro_t_sandy` | 18 KB | Trevor arriving at his Sandy Shores trailer (safehouse intro scene) |
| `finale_heist2_intro` | 16 KB | The Big Score: intro |
| `placeholdermission` | 15 KB | Template mission with the standard pass and fail texts (death and arrest of each character) |
| `family1taxi` | 8 KB | Support script for the taxi around Father/Son |
| `buddydeathresponse` | 8 KB | Mission rules for when a buddy dies (fail text, cleanup) |
| `pickupvehicles` | 3 KB | Support script for Scouting the Port (the container handler, tiny) |
| `assassin_rankup` | 1 KB | Tiny helper for the assassinations |
| `docks2asubhandler` | 1 KB | Support script for the submersible in the offshore approach |

### Strangers and freaks (88 scripts)

| Script | Size | What it does |
| --- | --- | --- |
| `mrsphilips2` | 2.5 MB | Mrs. Philips 2 |
| `extreme2` | 2.2 MB | Dom Beasley: extreme sports 2 |
| `extreme3` | 2.1 MB | Dom Beasley: extreme sports 3 |
| `epsilon7` | 1.8 MB | Epsilon Program mission 7 |
| `paparazzo1` | 1.2 MB | Beverly: Paparazzo 1 |
| `paparazzo2` | 1.2 MB | Paparazzo 2 |
| `hao1` | 1.2 MB | Hao: street race |
| `paparazzo3a` | 1.2 MB | Paparazzo 3A |
| `tonya1` | 1.2 MB | Tonya: towing 1 |
| `tonya2` | 1.2 MB | Tonya: towing 2 |
| `nigel1a` | 1.2 MB | Nigel: celebrity item A |
| `tonya5` | 1.2 MB | Tonya: towing 5 |
| `rampage1` | 1.1 MB | Trevor's rampage 1 |
| `rampage2` | 1.1 MB | Trevor's rampage 2 |
| `rampage3` | 1.1 MB | Trevor's rampage 3 |
| `rampage4` | 1.1 MB | Trevor's rampage 4 |
| `rampage5` | 1.1 MB | Trevor's rampage 5 |
| `minute1` | 1.1 MB | Joe and Josef (Minute Men) 1 |
| `tonya3` | 1.1 MB | Tonya: towing 3 |
| `tonya4` | 1.1 MB | Tonya: towing 4 |
| `extreme1` | 1.1 MB | Dom Beasley: extreme sports 1 |
| `josh2` | 1.1 MB | Josh Bernstein 2 |
| `minute2` | 1.1 MB | Minute Men 2 |
| `nigel1b` | 1.1 MB | Nigel: celebrity item B |
| `paparazzo3b` | 1.1 MB | Paparazzo 3B |
| `minute3` | 1.1 MB | Minute Men 3 |
| `josh3` | 1.0 MB | Josh Bernstein 3 |
| `nigel2` | 1.0 MB | Nigel 2 |
| `barry2` | 1022 KB | Barry: Grass Roots (Trevor) |
| `hunting2` | 1003 KB | Cletus: hunting 2 |
| `nigel1d` | 989 KB | Nigel: celebrity item D |
| `epsilon8` | 987 KB | Epsilon Program finale |
| `fanatic3` | 983 KB | Mary-Ann: Fanatic 3 |
| `nigel3` | 982 KB | Nigel 3 |
| `hunting1` | 960 KB | Cletus: hunting 1 |
| `nigel1c` | 955 KB | Nigel: celebrity item C |
| `epsilon6` | 941 KB | Epsilon Program mission 6 |
| `barry1` | 940 KB | Barry: Grass Roots (Michael) |
| `bailbond4` | 939 KB | Maude bail bond 4 |
| `bailbond2` | 932 KB | Maude bail bond 2 |
| `bailbond3` | 926 KB | Maude bail bond 3 |
| `bailbond1` | 924 KB | Maude bail bond 1 |
| `josh4` | 915 KB | Josh Bernstein 4 |
| `thelastone` | 914 KB | The Last One (Bigfoot hunt) |
| `barry3` | 896 KB | Barry: Grass Roots (Franklin), the stash cars |
| `paparazzo3` | 892 KB | Paparazzo 3 |
| `barry3c` | 886 KB | Barry: Franklin's stash car C |
| `barry3a` | 877 KB | Barry: Franklin's stash car A |
| `maude1` | 875 KB | Maude: the bail bond jobs intro |
| `fanatic1` | 874 KB | Mary-Ann: Fanatic 1 |
| `omega1` | 868 KB | Omega: spaceship parts intro |
| `fanatic2` | 867 KB | Mary-Ann: Fanatic 2 |
| `abigail2` | 866 KB | Abigail Mathers: What Lies Beneath |
| `epsilon4` | 835 KB | Epsilon Program mission 4 |
| `barry4` | 819 KB | Barry: Grass Roots finale |
| `dreyfuss1` | 812 KB | Peter Dreyfuss |
| `epsilon2` | 793 KB | Epsilon Program mission 2 |
| `paparazzo4` | 789 KB | Paparazzo 4 |
| `epsilon1` | 757 KB | Epsilon Program mission 1 |
| `nigel1` | 755 KB | Nigel and Mrs. Thornhill: intro |
| `extreme4` | 739 KB | Dom Beasley: extreme sports 4 |
| `epsilon3` | 737 KB | Epsilon Program mission 3 |
| `abigail1` | 734 KB | Abigail Mathers: Death at Sea |
| `epsilon5` | 719 KB | Epsilon Program mission 5 |
| `josh1` | 716 KB | Josh Bernstein 1 |
| `omega2` | 714 KB | Omega: finale |
| `mrsphilips1` | 663 KB | Mrs. Philips 1 |
| `epsrobes` | 548 KB | Epsilon: wear the robes |
| `epsdesert` | 541 KB | Epsilon: the desert walk |
| `ambient_tonya` | 193 KB | Tonya ambient towing call |
| `ambient_mrsphilips` | 178 KB | Mrs. Philips ambient scene |
| `altruist_cult` | 174 KB | The Altruist Cult camp (hitchhiker deliveries and the shoot-out) |
| `ambient_solomon` | 101 KB | Solomon ambient scene |
| `epscars` | 68 KB | Epsilon: deliver the cars |
| `fameorshame_eps` | 38 KB | Fame or Shame: the Epsilon contestant |
| `fameorshame_eps_1` | 38 KB | Fame or Shame: the Epsilon contestant, variant |
| `epsilontract` | 36 KB | Epsilon: the tracts |
| `maude_postbailbond` | 31 KB | Maude: after the bail bonds |
| `ambient_tonyacall` | 26 KB | Tonya phone call |
| `ambient_tonyacall2` | 25 KB | Tonya phone call 2 |
| `ambient_tonyacall5` | 25 KB | Tonya phone call 5 |
| `postrc_epsilon4` | 21 KB | After Epsilon 4 |
| `rampage_controller` | 20 KB | Shared rampage logic |
| `postrc_nigel3` | 18 KB | After Nigel 3 |
| `postrc_barry4` | 17 KB | After Barry 4 |
| `postkilled_bailbond2` | 14 KB | After the bail bond 2 target is killed instead of caught |
| `postrc_barry1and2` | 14 KB | After Barry 1 and 2 |
| `fame_or_shame_set` | < 1 KB | Fame or Shame set (empty in release) |

### Random events (38 scripts)

| Script | Size | What it does |
| --- | --- | --- |
| `re_chasethieves` | 735 KB | Chase the thieves |
| `re_crashrescue` | 670 KB | Crash rescue |
| `re_abandonedcar` | 651 KB | Abandoned car |
| `re_atmrobbery` | 282 KB | ATM robbery |
| `re_paparazzi` | 281 KB | Paparazzi |
| `re_muggings` | 279 KB | Mugging |
| `re_hitch_lift` | 277 KB | Hitchhiker (some go to the Altruist Cult) |
| `re_drunkdriver` | 266 KB | Drunk driver |
| `re_securityvan` | 246 KB | Security van |
| `re_getaway_driver` | 245 KB | Getaway driver |
| `re_snatched` | 235 KB | Snatched |
| `re_burials` | 209 KB | Burial in the desert |
| `re_cartheft` | 205 KB | Car theft |
| `re_stag_do` | 202 KB | Stag do |
| `re_domestic` | 190 KB | Domestic dispute |
| `re_yetarian` | 187 KB | Yetarian |
| `re_homeland_security` | 184 KB | Homeland Security |
| `re_arrests` | 182 KB | Arrest in progress |
| `re_bus_tours` | 182 KB | Bus tour |
| `re_accident` | 181 KB | Accident victim to take to hospital |
| `re_prisonvanbreak` | 178 KB | Prison van break |
| `re_dealgonewrong` | 176 KB | Deal gone wrong |
| `re_prisonerlift` | 174 KB | Escaped prisoner wants a lift |
| `re_duel` | 173 KB | Duel |
| `re_bikethief` | 171 KB | Bike thief |
| `re_seaplane` | 161 KB | Seaplane |
| `re_lured` | 140 KB | Lured into a trap |
| `re_gangfight` | 139 KB | Gang fight |
| `re_gang_intimidation` | 136 KB | Gang intimidation |
| `re_rescuehostage` | 132 KB | Rescue a hostage |
| `re_cultshootout` | 118 KB | Cult shoot-out |
| `re_border` | 111 KB | Border patrol |
| `re_monkey` | 104 KB | Monkey |
| `re_prison` | 97 KB | Near the prison |
| `re_armybase` | 79 KB | Near the army base |
| `re_mountdance` | 36 KB | Dance on the mountain |
| `re_lossantosintl` | 19 KB | At Los Santos International |
| `controller_ambientarea` | 7 KB | Starts area-based scripts when the player is near (strip club, golf foursome, prison and army base events) |

### Minigames, sports and activities (43 scripts)

| Script | Size | What it does |
| --- | --- | --- |
| `casinoroulette` | 7.6 MB | Casino roulette |
| `golf_mp` | 3.4 MB | Golf in Online |
| `pilot_school_mp` | 3.4 MB | Flight school (Online) |
| `range_modern_mp` | 3.1 MB | Shooting range (Online) |
| `golf` | 3.0 MB | Golf |
| `tennis_network_mp` | 2.9 MB | Tennis in Online |
| `act_cinema` | 2.6 MB | Watching a film at the cinema |
| `triathlonsp` | 2.6 MB | Triathlons |
| `tennis` | 2.6 MB | Tennis |
| `pilot_school` | 2.5 MB | Flight school (story) |
| `offroad_races` | 2.4 MB | Off-road races |
| `friendactivity` | 2.4 MB | Hanging out with a friend (drinks, darts, golf, tennis) |
| `range_modern` | 2.4 MB | Shooting range (story) |
| `stripclub_mp` | 2.3 MB | Strip club in Online |
| `hunting_ambient` | 2.3 MB | Free hunting |
| `stripclub` | 2.1 MB | Vanilla Unicorn strip club |
| `yoga` | 1.8 MB | Yoga |
| `stripclub_drinking` | 1.6 MB | Drinking at the strip club |
| `mission_race` | 808 KB | Races inside missions |
| `carwash2` | 772 KB | Car wash 2 |
| `carwash1` | 771 KB | Car wash 1 |
| `bigwheel` | 656 KB | Del Perro pier Ferris wheel |
| `stunt_plane_races` | 637 KB | Stunt plane time trials |
| `cablecar` | 629 KB | Mount Chiliad cable car |
| `bj` | 627 KB | Base jumping |
| `darts` | 627 KB | Darts |
| `blackjack` | 605 KB | Casino blackjack |
| `rollercoaster` | 591 KB | Del Perro pier roller coaster |
| `three_card_poker` | 566 KB | Casino three card poker |
| `country_race` | 471 KB | Country races |
| `photographymonkey` | 458 KB | Monkey mosaics (photograph the murals) |
| `mg_race_to_point` | 454 KB | Race to a point |
| `tennis_family` | 327 KB | Tennis with Amanda |
| `tennis_ambient` | 326 KB | Ambient tennis players |
| `stripperhome` | 195 KB | Taking a stripper home |
| `golf_ai_foursome` | 187 KB | AI golfers playing the course |
| `golf_ai_foursome_putting` | 168 KB | AI golfers putting |
| `fairgroundhub` | 100 KB | Pier fairground hub |
| `photographywildlife` | 64 KB | Wildlife photography |
| `flyunderbridges` | 49 KB | Under the bridge challenges |
| `country_race_controller` | 38 KB | Country races controller |
| `controller_races` | 13 KB | Street races controller |
| `shot_bikejump` | < 1 KB | Bike jump helper (tiny) |

### Odd jobs and street scenes (26 scripts)

| Script | Size | What it does |
| --- | --- | --- |
| `traffick_ground` | 602 KB | Trafficking: ground runs (Trevor) |
| `traffick_air` | 562 KB | Trafficking: air drops (Trevor) |
| `pb_prostitute` | 415 KB | Street scene: prostitute |
| `taxi_followcar` | 366 KB | Taxi job: follow that car |
| `taxi_procedural` | 342 KB | Procedural taxi fares |
| `taxi_gotyourback` | 341 KB | Taxi job: got your back |
| `taxi_cutyouin` | 341 KB | Taxi job: cut you in |
| `taxi_gotyounow` | 331 KB | Taxi job: got you now |
| `taxi_takeiteasy` | 330 KB | Taxi job: take it easy |
| `taxi_taketobest` | 328 KB | Taxi job: take to the best |
| `towing` | 322 KB | Towing jobs |
| `taxi_clowncar` | 318 KB | Taxi job: clown car |
| `taxi_needexcitement` | 317 KB | Taxi job: need excitement |
| `taxi_deadline` | 299 KB | Taxi job: deadline |
| `taxiservice` | 271 KB | Taking a taxi as a passenger |
| `controller_trafficking` | 211 KB | Trafficking controller |
| `controller_towing` | 167 KB | Towing controller |
| `controller_taxi` | 59 KB | Taxi jobs controller |
| `selling_short_2` | 38 KB | Selling Short 2 (to check) |
| `selling_short_1` | 38 KB | Selling Short 1 (to check) |
| `pb_homeless` | 21 KB | Street scene: homeless person |
| `pb_busker` | 15 KB | Street scene: busker |
| `pb_preacher` | 14 KB | Street scene: preacher |
| `traffickingsettings` | 1 KB | Trafficking settings helper (tiny) |
| `traffickingteleport` | 1 KB | Trafficking teleport helper (tiny) |
| `taxitutorial` | < 1 KB | Taxi job tutorial (empty in release) |

### Collectibles and easter eggs (9 scripts)

| Script | Size | What it does |
| --- | --- | --- |
| `murdermystery` | 90 KB | Murder mystery easter egg (to check) |
| `ambient_sonar` | 78 KB | Sonar collectibles (hidden packages) |
| `ufo` | 67 KB | UFO easter egg |
| `ambient_diving` | 48 KB | Diving spots |
| `letterscraps` | 46 KB | Letter scraps |
| `spaceshipparts` | 34 KB | Spaceship parts |
| `underwaterpickups` | 31 KB | Underwater pickups |
| `ambientblimp` | 12 KB | The blimp over the city |
| `ambient_ufos` | 9 KB | UFO sightings |

### Launchers (37 scripts)

| Script | Size | What it does |
| --- | --- | --- |
| `launcher_epsilon` | 915 KB | Epsilon |
| `launcher_rampage` | 593 KB | Rampages |
| `launcher_tennis` | 486 KB | Tennis |
| `launcher_nigel` | 340 KB | Nigel |
| `launcher_dreyfuss` | 315 KB | Dreyfuss |
| `launcher_barry` | 283 KB | Barry |
| `launcher_tonya` | 279 KB | Tonya |
| `launcher_josh` | 279 KB | Josh |
| `launcher_paparazzo` | 271 KB | Beverly |
| `launcher_abigail` | 264 KB | Abigail |
| `launcher_fanatic` | 264 KB | Mary-Ann |
| `launcher_minute` | 261 KB | Minute Men |
| `launcher_extreme` | 260 KB | Dom Beasley |
| `bailbond_launcher` | 259 KB | Bail bond jobs |
| `launcher_omega` | 254 KB | Omega |
| `launcher_hunting` | 252 KB | Cletus |
| `launcher_hao` | 250 KB | Hao |
| `launcher_maude` | 246 KB | Maude |
| `launcher_thelastone` | 245 KB | The Last One |
| `launcher_mrsphilips` | 240 KB | Mrs. Philips |
| `launcher_racing` | 220 KB | Street races |
| `apartment_minigame_launcher` | 197 KB | Darts and arm wrestling in Online apartments |
| `launcher_basejumpheli` | 156 KB | Helicopter base jumps |
| `taxilauncher` | 146 KB | Taxi jobs |
| `launcher_triathlon` | 136 KB | Triathlons |
| `launcher_darts` | 116 KB | Darts |
| `launcher_offroadracing` | 107 KB | Off-road races |
| `launcher_basejumppack` | 73 KB | Base jumps |
| `launcher_range` | 70 KB | Shooting range |
| `launcher_stunts` | 64 KB | Stunt plane races |
| `launcher_hunting_ambient` | 49 KB | Free hunting |
| `launcher_golf` | 48 KB | Golf |
| `launcher_yoga` | 45 KB | Yoga |
| `launcher_pilotschool` | 44 KB | Flight school |
| `launcher_carwash` | 42 KB | Car wash |
| `emergencycalllauncher` | 22 KB | 911 emergency calls |
| `activity_creator_prototype_launcher` | 5 KB | Prototype launcher for creator activities (empty in release) |

### World objects and the ambient world (41 scripts)

| Script | Size | What it does |
| --- | --- | --- |
| `animal_controller` | 2.1 MB | Animals |
| `ob_mp_shower_med` | 2.0 MB | Online shower |
| `ob_drinking_shots` | 1.8 MB | Drinking shots |
| `ob_bong` | 1.8 MB | Bong |
| `ob_franklin_wine` | 1.8 MB | Franklin's wine |
| `ob_franklin_beer` | 1.8 MB | Franklin's beer |
| `ob_wheatgrass` | 1.8 MB | Wheatgrass drink |
| `ob_vend1` | 1.6 MB | Vending machine 1 |
| `ob_vend2` | 1.6 MB | Vending machine 2 |
| `luxe_veh_activity` | 1.6 MB | Activities in luxury vehicles (champagne, cigars) |
| `ob_telescope` | 1.6 MB | Telescope |
| `music_studio_smoking` | 1.5 MB | Smoking at the music studio |
| `ob_mp_bed_high` | 1.5 MB | Online bed, high-end apartment |
| `ob_mp_bed_low` | 1.5 MB | Online bed, low-end apartment |
| `nightclubpeds` | 1.0 MB | Nightclub dancers and patrons |
| `si_dancing_activity` | 338 KB | Dancing and smoking activity in interiors |
| `localpopulator` | 268 KB | Local population for an area: car club peds and cars |
| `ob_jukebox` | 235 KB | Jukebox |
| `chop` | 208 KB | Chop the dog: following, fetch, sniffing |
| `ob_mp_stripper` | 127 KB | Online stripper |
| `laptop_trigger` | 125 KB | Office and business laptops (SecuroServ, Import/Export, biker business apps) |
| `atm_trigger` | 109 KB | ATMs |
| `ob_sofa_franklin` | 100 KB | Franklin's sofa |
| `ob_sofa_michael` | 93 KB | Michael's sofa |
| `ob_huffing_gas` | 79 KB | Trevor huffing gas |
| `sclub_front_bouncer` | 64 KB | Strip club bouncer |
| `ob_mr_raspberry_jam` | 52 KB | Mr. Raspberry Jam toy |
| `ob_mp_bed_med` | 48 KB | Online bed, mid-range apartment |
| `ob_tv` | 45 KB | TV (watch channels) |
| `forsalesigns` | 41 KB | The for-sale signs Josh asks Trevor to destroy |
| `ob_franklin_tv` | 39 KB | Franklin's TV |
| `restrictedareas` | 36 KB | Restricted areas (army base, prison, airport): wanted level on entry |
| `fake_interiors` | 13 KB | Fake interiors seen through windows (prison, military base, Kortz Center, warehouse) |
| `ob_cashregister` | 9 KB | Shop cash register (rob it) |
| `ob_abatdoor` | 4 KB | Abattoir door |
| `ob_poledancer` | 3 KB | Pole dancer (tiny) |
| `ob_foundry_cauldron` | 2 KB | Foundry cauldron (tiny) |
| `buildingsiteambience` | 2 KB | Construction site sound |
| `wp_partyboombox` | 1 KB | Party boombox prop (tiny) |
| `ob_abattoircut` | 1 KB | Abattoir cut (tiny) |
| `ob_airdancer` | 1 KB | Air dancer (tiny) |

### Arcade games, hacking minigames and gun cameras (15 scripts)

| Script | Size | What it does |
| --- | --- | --- |
| `missioniaaturret` | 8.1 MB | Online network script with bunker, Avenger and property code; likely the IAA facility turret (Doomsday), to check |
| `puzzle` | 7.6 MB | Online network script with property, door and vehicle code; purpose to check |
| `wizard_arcade` | 2.1 MB | Arcade game: The Wizard's Ruin |
| `ggsm_arcade` | 2.1 MB | Arcade game: Go Go Space Monkey |
| `road_arcade` | 2.1 MB | Arcade game: Race and Chase |
| `camhedz_arcade` | 2.1 MB | Arcade game: Camhedz |
| `gunslinger_arcade` | 2.1 MB | Arcade game: Badlands Revenge |
| `degenatron_games` | 1.8 MB | Arcade game: Degenatron |
| `scroll_arcade_cabinet` | 339 KB | Arcade cabinet (scrolling shooter) |
| `heli_gun` | 296 KB | Gunner seat camera for helicopters and aircraft |
| `grid_arcade_cabinet` | 272 KB | Arcade cabinet (grid game) |
| `dont_cross_the_line` | 162 KB | Arcade game: Don't Cross the Line |
| `turret_cam_script` | 80 KB | Turret and drone camera (Online) |
| `word_hack` | 77 KB | Hacking minigame: password (2024 DLC) |
| `circuitblockhack` | 44 KB | Hacking minigame: circuit board (2024 DLC) |

### Cut prototypes (5 scripts)

| Script | Size | What it does |
| --- | --- | --- |
| `pm_plane_promotion` | 138 KB | Prototype free-roam job: plane promotion |
| `pm_delivery` | 128 KB | Prototype free-roam job: delivery in a truck |
| `pm_recover_stolen` | 74 KB | Prototype free-roam job: recover a stolen vehicle |
| `pm_gang_attack` | 57 KB | Prototype free-roam job: gang attack |
| `pm_defend` | 35 KB | Prototype free-roam job: defend (gang goons, Mexican gang models) |

### Debug, test and empty scripts (108 scripts)

| Script | Size | What it does |
| --- | --- | --- |
| `nodemenututorial` | 169 KB | Example menu built with the shared menu code |
| `blimptest` | 10 KB | Test: blimp flight over the city |
| `scaleformtest` | 9 KB | Test: scaleform screens and input |
| `scaleformminigametest` | 9 KB | Test: scaleform screens and input |
| `scaleformprofiling` | 5 KB | Test: scaleform screens and input |
| `scaleformgraphictest` | 5 KB | Test: scaleform screens and input |
| `placementtest` | 4 KB | Test: splash text placement |
| `tempalpha` | 2 KB | Debug or test tool |
| `train_create_widget` | 2 KB | Debug or test tool |
| `planewarptest` | 2 KB | Test: warp a plane (tiny) |
| `debug` | 1 KB | Debug or test tool |
| `temptest` | 1 KB | Debug or test tool |
| `utvc` | 1 KB | Debug or test tool |
| `density_test` | 1 KB | Test: population density |
| `cam_coord_sender` | < 1 KB | Debug or test tool |
| `coordinate_recorder` | < 1 KB | Debug or test tool |
| `script_metrics` | < 1 KB | Debug or test tool |
| `scene_builder` | < 1 KB | Debug or test tool |
| `scripttest1` | < 1 KB | Debug or test tool |
| `scripttest2` | < 1 KB | Debug or test tool |
| `scripttest3` | < 1 KB | Debug or test tool |
| `charanimtest` | < 1 KB | Debug or test tool |
| `pickuptest` | < 1 KB | Debug or test tool |
| `playthrough_builder` | < 1 KB | Debug or test tool |
| `bootycall_debug_controller` | < 1 KB | Empty in release (debug or test script compiled out) |
| `debug_app_select_screen` | < 1 KB | Empty in release (debug or test script compiled out) |
| `flow_autoplay` | < 1 KB | Empty in release (debug or test script compiled out) |
| `friends_debug_controller` | < 1 KB | Empty in release (debug or test script compiled out) |
| `physics_perf_test_launcher` | < 1 KB | Empty in release (debug or test script compiled out) |
| `aicover_test` | < 1 KB | Empty in release (debug or test script compiled out) |
| `ainewengland_test` | < 1 KB | Empty in release (debug or test script compiled out) |
| `audiotest` | < 1 KB | Empty in release (debug or test script compiled out) |
| `basic_creator` | < 1 KB | Empty in release (debug or test script compiled out) |
| `bugstar_mission_export` | < 1 KB | Empty in release (debug or test script compiled out) |
| `camera_test` | < 1 KB | Empty in release (debug or test script compiled out) |
| `car_roof_test` | < 1 KB | Empty in release (debug or test script compiled out) |
| `combat_test` | < 1 KB | Empty in release (debug or test script compiled out) |
| `component_checker` | < 1 KB | Empty in release (debug or test script compiled out) |
| `creation_startup` | < 1 KB | Empty in release (debug or test script compiled out) |
| `cutscene_test` | < 1 KB | Empty in release (debug or test script compiled out) |
| `cutscenemetrics` | < 1 KB | Empty in release (debug or test script compiled out) |
| `cutscenesamples` | < 1 KB | Empty in release (debug or test script compiled out) |
| `debug_clone_outfit_testing` | < 1 KB | Empty in release (debug or test script compiled out) |
| `debug_launcher` | < 1 KB | Empty in release (debug or test script compiled out) |
| `debug_ped_data` | < 1 KB | Empty in release (debug or test script compiled out) |
| `dynamixtest` | < 1 KB | Empty in release (debug or test script compiled out) |
| `error_thrower` | < 1 KB | Empty in release (debug or test script compiled out) |
| `fps_test` | < 1 KB | Empty in release (debug or test script compiled out) |
| `fps_test_mag` | < 1 KB | Empty in release (debug or test script compiled out) |
| `fullmap_test` | < 1 KB | Empty in release (debug or test script compiled out) |
| `fullmap_test_flow` | < 1 KB | Empty in release (debug or test script compiled out) |
| `game_server_test` | < 1 KB | Empty in release (debug or test script compiled out) |
| `general_test` | < 1 KB | Empty in release (debug or test script compiled out) |
| `globals_fmmc_struct_registration` | < 1 KB | Empty in release (debug or test script compiled out) |
| `globals_fmmcstruct2_registration` | < 1 KB | Empty in release (debug or test script compiled out) |
| `globals_fmmcstruct3_registration` | < 1 KB | Empty in release (debug or test script compiled out) |
| `gtest_airplane` | < 1 KB | Empty in release (debug or test script compiled out) |
| `gtest_avoidance` | < 1 KB | Empty in release (debug or test script compiled out) |
| `gtest_boat` | < 1 KB | Empty in release (debug or test script compiled out) |
| `gtest_divingfromcar` | < 1 KB | Empty in release (debug or test script compiled out) |
| `gtest_divingfromcarwhilefleeing` | < 1 KB | Empty in release (debug or test script compiled out) |
| `gtest_helicopter` | < 1 KB | Empty in release (debug or test script compiled out) |
| `gtest_nearlymissedbycar` | < 1 KB | Empty in release (debug or test script compiled out) |
| `gunfighttest` | < 1 KB | Empty in release (debug or test script compiled out) |
| `headertest` | < 1 KB | Empty in release (debug or test script compiled out) |
| `heatmap_test` | < 1 KB | Empty in release (debug or test script compiled out) |
| `heatmap_test_flow` | < 1 KB | Empty in release (debug or test script compiled out) |
| `heli_streaming` | < 1 KB | Empty in release (debug or test script compiled out) |
| `hud_creator` | < 1 KB | Empty in release (debug or test script compiled out) |
| `idlewarper` | < 1 KB | Empty in release (debug or test script compiled out) |
| `item_ownership_output` | < 1 KB | Empty in release (debug or test script compiled out) |
| `line_activation_test` | < 1 KB | Empty in release (debug or test script compiled out) |
| `liverecorder` | < 1 KB | Empty in release (debug or test script compiled out) |
| `locates_tester` | < 1 KB | Empty in release (debug or test script compiled out) |
| `magdemo` | < 1 KB | Empty in release (debug or test script compiled out) |
| `magdemo2` | < 1 KB | Empty in release (debug or test script compiled out) |
| `mmmm` | < 1 KB | Empty in release (debug or test script compiled out) |
| `mptestbed` | < 1 KB | Empty in release (debug or test script compiled out) |
| `navmeshtest` | < 1 KB | Empty in release (debug or test script compiled out) |
| `nodeviewer` | < 1 KB | Empty in release (debug or test script compiled out) |
| `paradise` | < 1 KB | Empty in release (debug or test script compiled out) |
| `paradise2` | < 1 KB | Empty in release (debug or test script compiled out) |
| `physics_perf_test` | < 1 KB | Empty in release (debug or test script compiled out) |
| `profiler_registration` | < 1 KB | Empty in release (debug or test script compiled out) |
| `prop_drop` | < 1 KB | Empty in release (debug or test script compiled out) |
| `racetest` | < 1 KB | Empty in release (debug or test script compiled out) |
| `rcpdata` | < 1 KB | Empty in release (debug or test script compiled out) |
| `rerecord_recording` | < 1 KB | Empty in release (debug or test script compiled out) |
| `script_release.rpf___pilotschool_dlc_startup` | < 1 KB | Empty in release (debug or test script compiled out) |
| `scripted_cam_editor` | < 1 KB | Empty in release (debug or test script compiled out) |
| `scriptplayground` | < 1 KB | Empty in release (debug or test script compiled out) |
| `scripttest4` | < 1 KB | Empty in release (debug or test script compiled out) |
| `selector_example` | < 1 KB | Empty in release (debug or test script compiled out) |
| `shooting_camera` | < 1 KB | Empty in release (debug or test script compiled out) |
| `smoketest` | < 1 KB | Empty in release (debug or test script compiled out) |
| `sp_editor_mission_instance` | < 1 KB | Empty in release (debug or test script compiled out) |
| `speech_reverb_tracker` | < 1 KB | Empty in release (debug or test script compiled out) |
| `spmc_instancer` | < 1 KB | Empty in release (debug or test script compiled out) |
| `spmc_preloader` | < 1 KB | Empty in release (debug or test script compiled out) |
| `streaming` | < 1 KB | Empty in release (debug or test script compiled out) |
| `test_startup` | < 1 KB | Empty in release (debug or test script compiled out) |
| `train_tester` | < 1 KB | Empty in release (debug or test script compiled out) |
| `tunables_registration` | < 1 KB | Empty in release (debug or test script compiled out) |
| `veh_play_widget` | < 1 KB | Empty in release (debug or test script compiled out) |
| `walking_ped` | < 1 KB | Empty in release (debug or test script compiled out) |
| `weapon_audio_widget` | < 1 KB | Empty in release (debug or test script compiled out) |
| `xml_menus` | < 1 KB | Empty in release (debug or test script compiled out) |
| `script_debug.rpf___pilotschool_dlc_startup` | < 1 KB | Empty in release (debug or test script compiled out) |

## 1.5 What this means for modders

- **Copy the brain system's idea, not its code.** Rockstar's launchers are tiny scripts that only wake up near a point or a prop. Mods should work the same way: one cheap distance check against a list of points, and the heavy feature loaded only when the player is there. That is how 146 world features cost almost nothing until they're needed, which matters on a low-end PC. Natives to read up: the `BRAIN` namespace (`REGISTER_WORLD_POINT_SCRIPT_BRAIN`, `ENABLE_SCRIPT_BRAIN_SET`, `DISABLE_SCRIPT_BRAIN_SET`).
- **To stop story features during a custom Online mode**, switching off brain sets may be a cleaner tool for random events and ambient launchers than killing scripts one by one by name. Roadmap R5.7 should test which brain sets cover which groups.
- **Reading order for the next topics:** `standard_global_init` (the brain list and the globals it sets), `initial` and `main` (R1.2 boot), `flow_controller` and the four `mission_triggerer_*` scripts (R5.1 mission flow), one mission of each kind for R5.2, `selector` and `respawn_controller` (R6), `wardrobe_sp` (R6.3).
- **Activities an offline Online mode could reuse:** golf, tennis, the shooting range, flight school and the strip club already have Online versions in this group (`*_mp`), and the casino table games and arcade cabinets are here too. Each is a candidate for an offline activity once it is known what each needs from `freemode` (R7.1).
- **Lines marked "to check"** (`missioniaaturret`, `puzzle`, `murdermystery`, `selling_short_1` and `2`, `candidate_controller`) need a closer read before anything is built on them.
