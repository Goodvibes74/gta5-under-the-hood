# Music and radio

How GTA V's radio stations are defined and named, how mission scores are driven by music events, and how scripts tune, lock and silence the radio; plus what it takes to add or replace music. Roadmap topic **R9.3** in the [roadmap](/ROADMAP.md). Builds on [native usage](/scripting/native-usage.md) and [cutscenes and dialogue](/docs/gameplay/missions/cutscenes-and-dialogue.md). How audio banks and `.awc` files are organised is R9.1; station names are text labels (R8.3).

**How it was made.** The audio game data `update:/x64/audio/config/game.dat151.rel` and `dlc_gtao_game.dat151.rel`, and every DLC pack's `*_game.dat151.rel`, were extracted and converted to XML with CodeWalker's library (as [`tools/rpf-cw.ps1`](/tools/README.md) does); names were matched against every string literal in the decompile (Jenkins hash). Station display names come from the American `global.gxt2`. Station names, music events and their scripts were counted with `git grep -o` over every decompiled script (commit `6c18d3e8b`, literal names only). Native use from the [AUDIO](/scripting/native-usage/AUDIO.md) usage page. Build 1.0.3725.0 Legacy. Counts are **Verified**; how the audio engine plays them is **Known** unless stated.

## Short version

- **Stations are objects in `game.dat151`.** The base copy defines 33 `RadioStation` objects (the player stations plus hidden ones used in interiors and scenes), a `RadioStationList`, 79 `RadioTrack` objects and 751 `RadioTrackEvents`; DLC packs add more stations in their own `*_game.dat151.rel` files (Kult FM, MOTOMAMI, The Music Locker, the arcade and biker interiors ...).
- **Names follow `RADIO_<number>_<id>`:** `RADIO_01_CLASS_ROCK` is "Los Santos Rock Radio", `RADIO_02_POP` "Non-Stop-Pop FM", `RADIO_19_USER` "Self Radio", `RADIO_36_AUDIOPLAYER` "Media Player", `RADIO_37_MOTOMAMI` "MOTOMAMI Los Santos". The display name is a text label with the same name.
- **Hidden stations** (`HIDDEN_RADIO_*`) play from emitters (clubs, bars, the strip club, the arcade) and aren't on the wheel; `SET_EMITTER_RADIO_STATION` (135 scripts) points an emitter at a station.
- **Mission music is driven by events.** `TRIGGER_MUSIC_EVENT` is in 305 scripts with 3,692 calls; scripts name 1,547 different events by literal (`TRV1_...`, `EPS_...`, `FM_COUNTDOWN_30S` ...). `PREPARE_MUSIC_EVENT` (156 scripts) loads ahead and `CANCEL_MUSIC_EVENT` (98) drops one. In the audio data each event is a chain of `Mood`, `SetMoodAction`, `StartTrackAction` and `StopTrackAction` objects (1,505 moods, 578 start actions).
- **Scripts manage the radio around missions:** `SET_USER_RADIO_CONTROL_ENABLED` (324 scripts) locks the player's tuning, `SET_VEHICLE_RADIO_ENABLED` (317) silences a car, `SET_RADIO_TO_STATION_NAME` (289) and `SET_VEH_RADIO_STATION` (296) tune, and `SET_VEH_FORCED_RADIO_THIS_FRAME` (26) forces one.
- **Audio scenes** (`START_AUDIO_SCENE` 564 scripts, `STOP_AUDIO_SCENE` 572) duck the radio and ambience under cutscenes and set pieces.

## Where it lives

| File | What it holds | Count (build 3725) |
| --- | --- | --- |
| `update:/x64/audio/config/game.dat151.rel` | Game audio objects: stations, tracks, track events, moods and music actions, among thousands of other types | 33 stations, 79 tracks, 751 track event lists, 1,505 moods |
| `update:/x64/audio/config/dlc_gtao_game.dat151.rel` | Online additions to the same data | |
| DLC packs → `x64/audio/*_game.dat151.rel` | Stations and music added by each pack (registered as `AUDIO_GAMEDATA` in `content.xml`, 41 entries) | |
| `.awc` wave containers (`x64/audio/sfx/RADIO_*` ...) | The actual music and DJ audio | 244 file paths contain a radio folder (R9.1) |
| `global.gxt2` | Station display names (labels with the station name) | |
| `trackid.gxt2` | Song titles and artists for the track ID feature | 2,711 labels |

### The player stations

Literal `RADIO_NN_*` names in scripts and their display names (American text):

| Name | Display name | Name | Display name |
| --- | --- | --- | --- |
| `RADIO_01_CLASS_ROCK` | Los Santos Rock Radio | `RADIO_14_DANCE_02` | FlyLo FM |
| `RADIO_02_POP` | Non-Stop-Pop FM | `RADIO_15_MOTOWN` | The Lowdown 91.1 |
| `RADIO_03_HIPHOP_NEW` | Radio Los Santos | `RADIO_16_SILVERLAKE` | Radio Mirror Park |
| `RADIO_04_PUNK` | Channel X | `RADIO_17_FUNK` | Space 103.2 |
| `RADIO_05_TALK_01` | West Coast Talk Radio | `RADIO_18_90S_ROCK` | Vinewood Boulevard Radio |
| `RADIO_06_COUNTRY` | Rebel Radio | `RADIO_19_USER` | Self Radio |
| `RADIO_07_DANCE_01` | Soulwax FM | `RADIO_20_THELAB` | The Lab |
| `RADIO_08_MEXICAN` | East Los FM | `RADIO_21_DLC_XM17` | Blonded Los Santos 97.8 FM |
| `RADIO_09_HIPHOP_OLD` | West Coast Classics | `RADIO_22_DLC_BATTLE_MIX1_RADIO` | Los Santos Underground Radio |
| `RADIO_11_TALK_02` | Blaine County Radio | `RADIO_23_DLC_XM19_RADIO` | iFruit Radio |
| `RADIO_12_REGGAE` | Blue Ark | `RADIO_27_DLC_PRHEI4` | Still Slipping Los Santos |
| `RADIO_13_JAZZ` | Worldwide FM | `RADIO_34_DLC_HEI4_KULT` | Kult FM |
| | | `RADIO_35_DLC_HEI4_MLR` | The Music Locker |
| | | `RADIO_36_AUDIOPLAYER` | Media Player |
| | | `RADIO_37_MOTOMAMI` | MOTOMAMI Los Santos |

Other `RADIO_*` names in scripts are club and interior mixes (`RADIO_26_DLC_BATTLE_CLUB_WARMUP`, `RADIO_31_DLC_HEI4_KM_CLUB` ...) and track lists that scripts unlock on a station (`RADIO_09_HIPHOP_OLD_DD_MUSIC_LAUNCH` and other Dr. Dre contract lists). `RADIO_OFF` turns the radio off. **Known:** some DLC stations are Online-only or appear in story mode only after an update unlocks them; `GET_NUM_UNLOCKED_RADIO_STATIONS` (92 scripts) gives the current count.

## Mission music

**Verified (counts):** the scripts that trigger the most music events are the Online job controllers (`fm_mission_controller` 223 calls, `fm_mission_controller_2020` 220, `public_mission_controller` 208, `fmmc_launcher` 144, `freemode` 143) and, in story mode, `jewelry_heist` (57), `trevor1` (56) and `finale_heist2a` (51). Event names start with the mission or system they belong to: `FM_COUNTDOWN_30S` (68 literal uses across scripts), `MP_MC_*`, `TRV1_*` (Trevor 1), `EPS_*` (Epsilon), `BIKER_MP_MUSIC_*`, `TRV2_MISSION_*`, `EXEC1_START`, `APT_*`.

**Known (engine):** a music event names a mood or action in `game.dat151`; starting a score plays its track and layers (the `Mood` objects pick stems by intensity); later events in the same mission change the mood (more drums for a chase) or stop it. While scripted music plays the radio is ducked or muted (`AUDIO_IS_SCRIPTED_MUSIC_PLAYING`, 303 scripts). The `_STOP` or `_FAIL` events at the end of a mission return control to the radio.

## How scripts use the radio

| Native | Scripts | Calls | Use |
| --- | ---: | ---: | --- |
| `START_AUDIO_SCENE`, `STOP_AUDIO_SCENE`, `IS_AUDIO_SCENE_ACTIVE` | 564, 572, 489 | 4,896, 6,478, 4,718 | Mix states (duck the radio in cutscenes) |
| `SET_USER_RADIO_CONTROL_ENABLED` | 324 | 648 | Stop the player changing station |
| `SET_VEHICLE_RADIO_ENABLED` | 317 | 1,927 | Mute a vehicle's radio |
| `IS_RADIO_RETUNING` | 308 | 318 | The player is on the wheel |
| `TRIGGER_MUSIC_EVENT`, `PREPARE_MUSIC_EVENT`, `CANCEL_MUSIC_EVENT` | 305, 156, 98 | 3,692, 538, 297 | Mission score |
| `SET_VEH_RADIO_STATION`, `SET_RADIO_TO_STATION_NAME`, `SET_RADIO_TO_STATION_INDEX` | 296, 289, 84 | 626, 788, 124 | Tune |
| `GET_PLAYER_RADIO_STATION_INDEX`, `GET_PLAYER_RADIO_STATION_NAME` | 157, 116 | | Read the station |
| `SET_EMITTER_RADIO_STATION` | 135 | 433 | What a club or bar speaker plays |
| `SET_MOBILE_PHONE_RADIO_STATE` | 85 | 227 | Radio on foot through the phone |
| `SKIP_RADIO_FORWARD` | 50 | 52 | Skip to the next track |
| `UNLOCK_RADIO_STATION_TRACK_LIST`, `FORCE_MUSIC_TRACK_LIST` | 17, 17 | 60, 36 | Unlock or force a track list (DLC music drops) |

## Adding or replacing music

**Known:**

- **Replacing a song** means replacing the station's `.awc` file with one of the same name and length metadata; a song of a different length needs the track's data in `game.dat151` changed too. Tools such as OpenIV and CodeWalker can open `.awc` files; replace them through the mods folder, never in the original archives.
- **Adding a station** needs a DLC pack with its own `*_game.dat151.rel` (a new `RadioStation` and its tracks), `*_sounds.dat54.rel`, the `.awc` files, a text label for the name, and `AUDIO_GAMEDATA` / `AUDIO_SOUNDDATA` / `AUDIO_WAVEPACK` entries in `content.xml`, as Rockstar's packs do. Community add-on station tools write these files; link to their pages rather than shipping them.
- **Self Radio** (`RADIO_19_USER`) plays the player's own music files from the game's user music folder with no modding at all.
- **Script control** works without any of that: a mod can switch stations, lock the radio, or play a mission-style score with existing music events.

## What this means for modders

- Tune with `SET_RADIO_TO_STATION_NAME("RADIO_02_POP")` or `SET_VEH_RADIO_STATION(vehicle, name)`; turn off with `"RADIO_OFF"`.
- Lock the player's choice with `SET_USER_RADIO_CONTROL_ENABLED(false)` and give it back when your mod stops.
- Play mission-style music with `PREPARE_MUSIC_EVENT` then `TRIGGER_MUSIC_EVENT` on an existing event, and end it with that mission's stop event; an unfinished score keeps the radio muted.
- Use `START_AUDIO_SCENE` with an existing scene to duck the radio under your own dialogue, and always stop it.
- **Single player only.**

## Open questions

| Question | Where it goes |
| --- | --- |
| The 10 base and many DLC station objects whose names didn't resolve | Second pass with more name sources |
| How a music event maps to moods and tracks, step by step | R9.1, second pass |
| Which DLC stations are available in story mode in build 3725 | Test card 1 |
| The format of a radio track's data (length, markers for the DJ) | R9.1 |

## Test cards

1. **Station list.** In story mode, open the radio wheel in a car and count stations; print `GET_NUM_UNLOCKED_RADIO_STATIONS`. Expected: the two match.
2. **Lock.** `SET_RADIO_TO_STATION_NAME("RADIO_13_JAZZ")` and `SET_USER_RADIO_CONTROL_ENABLED(false)`. Expected: Worldwide FM plays and the wheel doesn't change it.
3. **Score.** Trigger a known start event from a story mission and its stop event 30 s later. Expected: the score plays, the radio drops out, then returns.
