# Anatomy of a story mission

What a story mission script looks like inside: how it starts, how it splits into stages and sub-steps, how checkpoints, retries and "skip this section" work, how it fails and passes, and how it cleans up. Three missions of different kinds were read side by side: `armenian1` (Franklin and Lamar, a driving mission), `jewelry_heist` (The Jewel Store Job, a heist finale with two approaches and a crew) and `trevor1` (Mr. Philips, a shootout with a moral choice). Roadmap topic **R5.2** in the [roadmap](/ROADMAP.md). It follows [guide 2](/docs/gameplay/missions/story-flow.md), which explains how a mission is unlocked and launched.

**How it was made.** Read from the build-3725 decompile (`armenian1`, `jewelry_heist`, `trevor1`, and `replay_controller` for the retry screen). The three scripts are about 130,000 to 140,000 decompiled lines each, but most of that is shared library code compiled into every mission; the mission's own logic is a few thousand lines. Function, variable and global names in this guide are the decompiler's (`func_878`, `Global_102429`); they change between builds, so treat them as pointers for this build only. Names in *italics* are ours. **Verified** means read in the decompile; **Known** means general knowledge, still to check.

## 3.1 Short version

- **Every mission is one script with one loop.** It sets the mission flag, registers a force cleanup handler, prepares the world, then loops forever: wait a frame, run the global checks (is a buddy dead? is the car wrecked?), then run the current stage.
- **Stages and sub-steps.** A *stage* number picks which function runs this frame. Inside a stage, a *step* number moves through the same five states in every mission: set up after a restart, set up normally, run, finish and move on, skip.
- **Checkpoints are separate from stages.** A mission has far fewer checkpoints than stages (`armenian1`: 11 stages, 4 checkpoints). Reaching a checkpoint records its number and name, saves a snapshot of the player (weapons, outfit, vehicle), resets the "failed here" counter and sends a telemetry stat.
- **Fail is one function with a reason number.** Each reason maps to a text label (`AR1_FAILBUDDY`: "Lamar died"). The function cleans the scene, shows the reason, marks the mission failed for `replay_controller`, waits for the retry screen, then runs the full cleanup.
- **Retry restarts the script.** `replay_controller` shows the fail screen (retry, restart, skip, exit) and relaunches the mission. The new copy reads which checkpoint to start from and jumps to that stage in its "set up after a restart" step.
- **Pass** sets the mission's "passed" bit, which `flow_controller` and `mission_repeat_controller` pick up; the mission then cleans up and ends.
- **Cleanup is one long function** that puts every global setting the mission touched back to normal (wanted level, traffic, dispatch, radio, player control) and deletes or releases everything the mission made. Fail, pass and force cleanup all end there.

## 3.2 The three missions

| | `armenian1` | `jewelry_heist` | `trevor1` |
| --- | --- | --- | --- |
| In game | Franklin and Lamar | The Jewel Store Job | Mr. Philips |
| Kind | Driving, chase, cops | Heist finale, two approaches, crew | Chase, shootout, choice |
| Stage variable | 12 values used (0 to 11) | 17 values (0 to 16) | 12 values (0 to 10, 12) |
| Checkpoints | 4 | 8 (approach B) or 9 (approach A) | 7 |
| Fail reasons | 22 | 27 | about 13 labels |
| Replay event name | `M_FranklinAndLamar` | `M_TheJewelStoreJob` | `M_MrPhilips` |
| Text block | `ARM1` | `JH` / `JH2` | `T1M1` |

The replay event name is passed to `REPLAY_CHECK_FOR_EVENT_THIS_FRAME` every frame, which is how the Rockstar Editor's "mission" recording markers know where they are (**Verified** call, meaning **Known**).

## 3.3 Start-up

Every one of the three does the same things in the same order before its loop (**Verified**):

1. **Locals.** Coordinates, model hashes, animation dictionaries, cutscene names and the conversation block are set first. In `armenian1` that is about 140 values, for example the cutscenes `armenian_1_int`, `armenian_1_mcs_1`, `arm_1_mcs_2_concat` and the models `ninef2`, `rapidgt2`, `manana`.
2. **`SET_MISSION_FLAG(true)`.** Tells the engine and every other script that a mission is running. 200 scripts set it.
3. **Force cleanup handler.** `HAS_FORCE_CLEANUP_OCCURRED(3)` registers for bits 1 and 2 ([engine guide 2](/scripting/script-vm.md#26-force-cleanup)). When it fires (death, arrest, the switch to Online), the handler starts `buddyDeathResponse` if needed (`armenian1`), marks the mission failed, runs the full cleanup and ends the thread. `trevor1` also plays its fail music (`TRV1_FAIL`) and handles arrest separately.
4. **World set-up.** Text block (`REQUEST_ADDITIONAL_TEXT`), the player's conversation voice, relationship groups, suppressed vehicle models (so traffic doesn't spawn the cars the mission uses), scenario blocking areas, roads switched off, wanted level cleared, special ability unlocked or turned off, weather and clock. `armenian1` sets the clock to 08:00 on 6 May 2009.
5. **Restart or fresh start.** If `replay_controller` says this is a restart (3.6), read the checkpoint and jump to its stage; otherwise record checkpoint 0 (`OPENING_CUTSCENE` in `armenian1`) and start at stage 0.
6. **`NETWORK_SET_CAN_RECEIVE_RS_INVITES(false)`** (`armenian1`): no Online invites during the mission.

`jewelry_heist` adds the heist parts before its loop: it reads which approach the player chose (3.8) and the chosen crew, and puts the take counter on screen.

## 3.4 The main loop

Each frame (**Verified**, `armenian1`):

1. `WAIT(0)`, then the replay event check.
2. **Global fail checks**, which run whatever stage is active: the two race cars (fail 3, 4 or 2 when one or both are wrecked), the getaway car being stuck (7, 8), Lamar, Simeon or Jimmy dead (1, 19, 20). Each check only runs for the stages where it makes sense (`stage < 11`, `stage > 2`).
3. **Stage-wide extras**: from stage 6 on, the special ability bar fills over time; from stage 10, a stat watcher runs.
4. **The stage switch**: one function per stage.
5. A small per-frame function after the switch (in `armenian1`, the special ability meter during the race).

`trevor1` puts its global checks first too: it changes the relationship between the bikers and the cops when the player gets a wanted level, catches arrest, and scales traffic density by stage (none during the trailer push, 0.4 during the drive). `jewelry_heist` checks "is the player in control" before its fail check, so a fail never fires during a cutscene.

## 3.5 Stages and steps

**The stage list of `armenian1`** (**Verified**; names are ours, the labels are the game's):

| Stage | What happens | Checkpoint reached | Labels and assets |
| --- | --- | --- | --- |
| 0 | Opening cutscene at Simeon's | 0 `OPENING_CUTSCENE` | `armenian_1_int` |
| 1 | Walk out with Lamar, choose a car | | `AR1_CHOOSE`, `AR1_CARHELP`, `ARM_1_CHOOSE_CAR` |
| 2 | Get in, scripted camera on the car | | `carrace_walktocar_*` animations |
| 3, 4 | The race across the city, Lamar's taunts, phone call | 1 `CHASE_MID_POINT` | `ARM_1_DRIVE_*` audio scenes, vehicle recording `mattarmenian` |
| 5 | Cops arrive at the finish (scripted camera) | | `police3`, `s_m_y_cop_01` |
| 6 | Lose the cops (wanted level 2), special ability tutorial | 2 `LOSE_COPS` | `AR1_RAGEBAR`, `AR1_COPHELP1` to `3` |
| 7 | Drive to the dealership | | `ARM_1_DRIVE_TO_DEALERSHIP` |
| 8 | Lead-in to Simeon and Jimmy | | `ARM1_MCS1LI` |
| 9 | Showroom cutscene | | `armenian_1_mcs_1` |
| 10 | Drive home, the car must not be damaged | 3 `GO_TO_HOUSE` | `AR1_HOME`, fails 12 to 14, 18 |
| 11 | Final cutscene, tutorials at Franklin's house (save, wardrobe, TV, health), **pass** | | `arm_1_mcs_2_concat`, `AR1_SAVE1`, `AR1_MEDIHELP` |

**The step variable.** Every stage function reads a second number with the same five values in all three missions (**Verified** in `armenian1`, same pattern in the others):

| Step | Meaning |
| --- | --- |
| 4 | **Set up after a restart or skip.** Warp the player to the stage's start (through `replay_controller` when restarting, so the screen stays faded and the scene loads), recreate the entities this stage needs, then go to 0 |
| 0 | **Set up.** Request models, animations and the cutscene; when everything is loaded create the entities, give the objective, record the checkpoint if this stage has one, then go to 1 |
| 1 | **Run.** Per-frame logic: tasks, dialogue, help text, objective checks and the stage's own fail checks. Goes to 2 when the goal is met, to 3 when the player skips |
| 2 | **Finish.** Clean up what this stage alone used, set the stage number to the next stage and the step back to 0 |
| 3 | **Skip.** A skipped cutscene (`WAS_CUTSCENE_SKIPPED`) or a skipped scripted scene jumps to the next stage through the same path as a restart (step 4) |

Most of the code of a stage is in step 1. A stage with a cutscene follows a fixed sequence: request it, wait for `HAS_CUTSCENE_LOADED` (on PC through a helper that also checks the cutscene's entities), register the mission's peds and cars with the cutscene, `START_CUTSCENE`, then watch for the exit points of each entity to hand them back to the script. Cutscenes get their own guide in R5.6.

## 3.6 Checkpoints, retry and skip

**Recording a checkpoint** (**Verified**, `func_893` in `armenian1`, `func_680` in `jewelry_heist`, `func_580` in `trevor1`; the same shared function in each). Arguments: checkpoint number, name, a "last checkpoint" flag, and two options. When the number is higher than the current one:

1. The "failed at this checkpoint" counter in the mission's save record (`f_9092.f_330[mission].f_1`, [guide 2](/docs/gameplay/missions/story-flow.md#23-where-the-flow-lives-in-the-save)) goes back to 0.
2. `PLAYSTATS_MISSION_CHECKPOINT` sends the short code, the checkpoint, the old and the new number (telemetry; for the finale it adds `A` or `B` from flow integer `f_205[7]`).
3. The current checkpoint (`Global_102466`) and the "last checkpoint" flag (`Global_96582`) are set.
4. **A snapshot of the player** goes into `Global_108447`: position and vehicle, weather, current weapon, every character's outfit and props, all weapons and attachments of all three characters, and the purchased-weapon stats. This is what a retry gives back, so a retry doesn't keep ammo or damage from the failed attempt (**Verified** capture; restore read in the second pass, below).

**Restoring the snapshot** (*second pass*, `replay_controller` build 3725, **Verified**). When the player retries (or skips), `replay_controller` recreates the snapshot's vehicle (with its colours, mods, plate and roof state) and applies the rest; the mission's own checkpoint code places the player (**Known**):

1. **Always:** the clock time and date, and the weather.
2. **For the characters:** each character's special-ability charge (the `SPx_SPECIAL_ABILITY` stats), weapons and attachments, outfit components and props, and tattoos are copied back into the story save; each character's cash is set back to the snapshot amount, and the bank-account log is rewound to its length at the checkpoint (up to 11 entries), so money spent or earned during the failed attempt is undone.
3. **Phone:** text messages received after the snapshot's time are deleted.
4. **The player ped:** the outfit is re-applied; wetness, blood and visible damage are cleared; the snapshot's current weapon is selected if the ped still has it; health is set to full and stamina reset; the wanted level is cleared.

**What it leaves out:** anything that isn't in the snapshot. Stats other than special ability (kills, distances, the `MONEY_SPENT_*` bookkeeping), completion entries, collectables and flow flags set during the failed attempt stay as they are; so does the world (other vehicles, peds, doors).

The checkpoint names are the developers' and say what the checkpoint is for: `armenian1` has `OPENING_CUTSCENE`, `CHOOSE_CAR`, `CHASE_MID_POINT`, `LOSE_COPS`, `GO_TO_HOUSE`; `trevor1` has `Get to Chase`, `Chase the bikers`, `Caravan Park Fight`, `Drive to the trailer`, `Push the trailer`, `Kill / Threaten Ortega`, `Drop Off Ron`; `jewelry_heist` has `STAGE_DRIVE_TO_STORE`, `STAGE_ROOF` (approach A only), `STAGE_GRAB_LOOT`, `STAGE_BIKE_CHASE`, `..._START_OF_TUNNEL`, `..._END_OF_TUNNEL`, `STAGE_CUTSCENE_RAMP_DOWN`, `STAGE_RETURN_TO_BASE`. 150 scripts record checkpoints this way.

**The retry screen.** `replay_controller` owns a state value (`Global_102429`) and the screen (**Verified** reading, the state names are ours):

| State | What it means |
| --- | --- |
| 7 | Player chose retry; the mission is being relaunched |
| 8 | Player chose exit (or the mission can't be replayed) |
| 9 | Relaunched mission is starting from a checkpoint |
| 10 | Relaunched mission is starting, set-up stage |
| 11 to 13 | Restart paths that end the replay (to check) |

The fail screen offers **Retry** (from the last checkpoint, when there is one), **Restart** (from the start), **Skip** and **Exit**. `Global_102429.f_2` holds the checkpoint to restart from. When the relaunched mission starts, it checks for state 9 or 10, reads `f_2` and jumps to that checkpoint's stage with step 4 (**Verified**).

**Skip ("skip this section").** The skip button appears when `Global_96580` is set. In 72 mission scripts that set it, the rule is: the player has failed at least **twice** at the same checkpoint and the mission's option flags (mission table field 15, bit 16) don't forbid it (**Verified** in `abigail1`). Choosing skip sets `Global_96581`, adds 1 to the `times_mission_skipped` stat, and the relaunched mission starts **one checkpoint later** than it would have. When the failed checkpoint is the last one (the "last checkpoint" flag), the screen offers to skip the whole mission instead (`REPLAY_SKIPM` instead of `REPLAY_SKIPS`). `armenian1`, `jewelry_heist` and `trevor1` don't contain the check that sets `Global_96580` themselves, but all three honour `Global_96581`; where their skip unlock happens is an open question (3.12).

## 3.7 Failing

**`armenian1`'s fail function** (`func_878`, **Verified**) takes a reason number and, once only:

1. Clears prints and help, removes the GPS route, unfreezes the race cars, makes Simeon and Jimmy flee.
2. Looks up the reason label: 1 `AR1_FAILBUDDY`, 2 to 4 car wrecked, 5 `AR1_FAILLOST` (lost Lamar), 7 and 8 stuck, 9 `AR1_FAILLEFT` (left Lamar behind), 10 `AR1_FAILCOPS`, 11, 12 and 21 car damaged, 13 car left behind, 14 to 18 showroom fails (`AR1_FAILSHOW1` to `5`), 19 and 20 Simeon or Jimmy dead, 22 `AR1_FCOPSDEAL` (brought cops to the dealership); 6 is the shared `CMN_GENDEST`.
3. Hands the label to the shared fail routine, which: starts a 5-second firing amnesty, charges the special ability as the game does on any fail, records the fail in the player's mission stats, adds 1 to the mission's fail counters in the save (`f_330[mission].f_1` when the fail is at the same checkpoint as the last one, `f_2` always), and sets **bit 5 (failed)** on the running-mission slot (3.9).
4. Waits until `replay_controller` reaches state 7 or 8 (the player chose) or the game is shutting down.
5. Releases Lamar from the player's group if he's alive and nearby, then runs the full cleanup (3.10).

`jewelry_heist` has the same shape with 27 reasons. Most labels sit in a table (`Local_3373.f_201` to `f_217`), but it is filled once with fixed labels (`M_FAIL`, `F_ABANDON`, `F_KILLCREW`, `F_LOSECREW` ...), not by crew choice. A dead crew member gets one of three fixed lines by role: `JH2_HCKDEAD` "The hacker died.", `JH2_HCKGUN` "The gunman died." and `JH2_HCKDRV` "The driver died." (*second pass, 2026-10-30*, **Verified**: the only writes to the table are those fixed strings). Shared labels (`F_ARRESTED`, `F_BLEW`, `F_INSUFTAKE`, `F_SECESCAPE`) and heist-specific ones (`JH_FAILCLOSE`, `JH2_HCKDEAD`, `JWL_GASFAIL`, `F_GAS`) fill the rest. It plays `JH2A_MISSION_FAIL` or `JH2B_MISSION_FAIL` by approach (**Verified**).

## 3.8 Choices inside a mission

**Heist approach.** `jewelry_heist` reads flow integer `f_205[7]` ([guide 2](/docs/gameplay/missions/story-flow.md#23-where-the-flow-lives-in-the-save)): 1 is approach A, 2 is approach B (**Verified**). The two share most stages; A adds stage 4, the roof (`JSH_2A_GET_TO_ROOF`, `JSH_2A_THROW_GAS`, `weapon_bzgas`), and therefore has one checkpoint more, so every checkpoint number after it is shifted by one (**Verified**: `STAGE_GRAB_LOOT` is checkpoint 3 on A and 2 on B). Its restart code has two lookup tables, one per approach, from checkpoint to stage. A is the gas-from-the-roof approach (smart); B is the loud one (**Known**, matches the assets).

**Crew.** The crew picked in the planning board is read from the save (`Global_114904.f_1.f_12`, slot 0 and 1) and turned into the crew members' names, models and lines (`gunman_selection_1`, `Driver_selection`, `Hacker_selection`). Crew skill sets how much of the take survives (**Known**, to check in R7.8 for heists).

**The take.** The take is shown with `CMN_TAKE` and grows smoothly towards its target value (255,000 per second). On a retry the take so far comes back from `Global_102429.f_12[0]`, so a retry doesn't reset it (**Verified**).

**A moral choice.** `trevor1` ends with "Kill / Threaten Ortega" (checkpoint 5): the outcome is kept in the story stat `sp_killed_ortega`, which later scripts read (**Verified** stat name).

## 3.9 Passing

The shared pass routine (`func_5` in `armenian1`, **Verified**):

1. Finds the mission's slot in the **running-mission list** (`Global_93156`, 7 slots of 5 values; bit 2 means "in use", bit 4 passed, bit 5 failed).
2. If neither passed nor failed yet, sets **bit 4 (passed)** on the slot, sets bit 1 of `Global_80529` and stores the mission number and the game timer (`Global_80545`, `Global_80546`).
3. `flow_controller` (moves the strand on, [guide 2](/docs/gameplay/missions/story-flow.md#24-the-flow-program)) and `mission_repeat_controller` (replays from the pause menu, which must not move the flow) read those values (**Verified** that both read `Global_80529`).

**How a replay leaves the flow alone** (*second pass*, `mission_repeat_controller` build 3725, **Verified**). Replaying a mission from the pause menu works by saving the whole game first and loading it again afterwards:

1. The controller fades the screen out, calls `SET_PLAYER_IS_REPEATING_A_MISSION(true)`, stores the player's position in the save, and writes a temporary save with `QUEUE_MISSION_REPEAT_SAVE`. It waits while `GET_STATUS_OF_MISSION_REPEAT_SAVE` is 1 (busy); if it returns 2 (failed), the replay is called off.
2. It clears the save's **flow-started flag** (`f_9092`, the first value of `FLOW_STRUCT`). `flow_controller` only runs the flow while that flag is set, so nothing the replayed mission does (its pass bit, flow flags) moves a strand.
3. It starts the mission script itself (stack 64,500; strangers-and-freaks missions by name) and `mission_stat_watcher` (stack 1,828) for the medal screen, and waits for the mission to end. For the heist finales it also waits for the extra scripts they launch.
4. On a pass it waits up to 20 seconds for the stats screen and up to 30 more while it is shown (missions 19, 21, 22, 84, 85 and 90 skip this wait), fades out, and calls `QUEUE_MISSION_REPEAT_LOAD`; on a fail or quit it loads straight away. The load puts back the game exactly as it was before the replay, so money, weapons and story state from the replay are gone.
5. Finally it sets the flow-started flag again, clears the running-mission bits in `Global_80529`, calls `SET_PLAYER_IS_REPEATING_A_MISSION(false)` and ends.

If a force cleanup hits during a replay (going to GTA Online), the controller queues the same load before it ends, so the Online switch doesn't keep the replay's state.

Before calling it, `armenian1`'s final stage stops the last cutscene, unlocks Franklin's special ability for good, shows the save and wardrobe tutorials, and records the end-of-mission stats; after it, the full cleanup runs. Medals are worked out from the mission's stat list in the mission table (`f_16`, `f_17`; `mission_stat_watcher`, started by `replay_controller`); that is part of R5.3.

## 3.10 Cleanup

`armenian1`'s cleanup (`func_959`, **Verified**) is the reverse of the set-up. It puts back: wanted level multiplier and maximum, random cops, dispatch services, vehicle and ped population budgets (3), parked cars, vehicle generators, radio, aggressive horns, cinematic camera, road GPS flag, scripted load scenes, camera hints and shakes. For the player: control on, tasks cleared, visible, not invincible, no proofs, weapon visible, special ability enabled, capsule size and wanted difficulty reset. Then it stops any running cutscene and replay recording, stops looped particle effects, and releases or deletes every ped, vehicle and object the mission made, before `TERMINATE_THIS_THREAD`.

When the step is 4 (a restart is setting up), the same cleanup runs but clears the player's tasks immediately and waits for the cutscene to end, so the new set-up starts from a clean world.

## 3.11 What this means for modders

- **A template for custom missions.** Any mod mission (story-style or Online-style) can follow the same shape: one loop, global fail checks first, a stage switch, and the five-step pattern inside each stage. Step 4 (set up after a restart) is what makes checkpoints cheap: every stage must be able to build its own scene from nothing.
- **Fail and pass through one function each.** One fail function with a reason table and one pass function, both ending in one cleanup that undoes every global change, is the single most useful rule. Most mod bugs that leave the world broken (no cops, no traffic, no radio) come from a missing cleanup path.
- **Don't fight `replay_controller`.** Our missions shouldn't set the running-mission bits or `Global_102429`; those belong to Rockstar's missions. A mod mission should keep its own checkpoint and snapshot. Reading `Global_93156` (is a Rockstar mission running?) and the mission flag is safe, and a mod should stay idle while either is set.
- **Respect the mission flag.** 200 scripts set it. Ambient mods (gang wars, zombies, police overhauls) should check `GET_MISSION_FLAG` and pause their spawns while a mission runs; the missions assume they control traffic and dispatch.
- **Telemetry stays local.** `PLAYSTATS_MISSION_CHECKPOINT` is a stat call; with no network it goes nowhere, so mod missions don't need to stub it.

## 3.12 Open questions

| Question | Where it goes |
| --- | --- |
| Where `armenian1`, `jewelry_heist` and `trevor1` set the skip flag (`Global_96580`), since they don't do it in their own code | Next pass of R5.2 or R5.8 |
| The exact meaning of `replay_controller` states 1 to 6 and 11 to 13 | R5.8 |
| How the snapshot in `Global_108447` is restored on retry, and what it leaves out | Answered in [3.6](#36-checkpoints-retry-and-skip) |
| How crew skill changes the heist take and the fail labels in `Local_3373` | Partly answered (second pass): the fail labels are fixed, not chosen by crew; how crew skill changes the take is left for the third pass |
| How `mission_repeat_controller` replays a mission without moving the flow (from guide 2) | Answered in [3.9](#39-passing) |
| What the mission triggerers build before a mission starts (lead-in scenes, from guide 2) | R5.2 second pass |
