# How audio is organised

Where GTA V's sound lives and how scripts reach it: the 54 sound archives and what each holds, the audio configuration files (`.dat*.rel`) and their kinds, sounds and sound sets, audio scenes, script audio banks and streams, the natives Rockstar's scripts use and how often, and what a mod can add or replace. Roadmap topic **R9.1** in the [roadmap](/ROADMAP.md). Builds on [music and radio](/docs/audio/music-and-radio.md) (R9.3: stations and music events) and [archives and content](/docs/core/archives-and-content.md) (R1.6: how DLC registers audio).

**How it was made.** The archives in `x64\audio` of a build 1.0.3725.0 install were listed with their sizes; `x64\audio\audio_rel.rpf` and the `x64\audio\config` folder of `update\update.rpf` were listed with [`tools/rpf-cw.ps1`](/tools/README.md). Every `PLAY_SOUND*`, `START_AUDIO_SCENE`, `REQUEST_SCRIPT_AUDIO_BANK`, `REQUEST_AMBIENT_AUDIO_BANK` and `LOAD_STREAM` call (42,232 in all) was pulled from the decompile (commit `6c18d3e8b`) with `git grep`, and names counted. Native counts from [native usage](/scripting/native-usage.md). Counts are **Verified**; what each config file type does is **Known** (community format work, CodeWalker), as is what a bank is inside the engine.

## 27.1 Short version

- **The sound itself sits in 54 archives** under `x64\audio\sfx` (about 17 GB together), each full of `.awc` wave containers: interactive music (2.9 GB, the largest), cutscene audio (1.8 GB), 19 radio-station archives, scripted speech (`SS_*`, 8 archives), ambient speech (`S_FULL_*`, `S_MINI_*`, `S_MISC`), streamed vehicles, ambience, animals, pain, the police scanner, weapons, `RESIDENT` (always loaded) and `SCRIPT` (banks scripts load).
- **What a sound *is* lives in the config files** in `audio_rel.rpf`, with newer copies in `update.rpf`: `sounds.dat54.rel` (1.3 MB; sounds and sound sets), `game.dat151.rel` (601 KB; game objects such as stations, vehicles' audio, doors, emitters), `speech2.dat4.rel` (709 KB; voices), `optamp.dat10.rel`, `dynamix.dat15.rel` (mixing and scenes), `curves.dat16.rel`, `categories.dat22.rel`, `audioconfig.dat4.rel`, plus `sp_sounds` and the Online (`dlc_gtao_*`) and title-update (`dlctu_*`) additions.
- **Scripts play sounds by name and set:** `PLAY_SOUND_FRONTEND` (640 scripts, 27,190 calls), `PLAY_SOUND_FROM_ENTITY` (444, 4,831), `PLAY_SOUND_FROM_COORD` (361, 1,543), `PLAY_SOUND` (45, 150). Literal calls name 1,069 sound/set pairs from 334 sound sets.
- **The busiest sound set is the menu one:** `HUD_FRONTEND_DEFAULT_SOUNDSET` (6,291 calls: `SELECT` 2,452, `CANCEL` 997, `NAV_UP_DOWN` 825, `NAV_LEFT_RIGHT` 673, `BACK` 316, `ERROR` 296), then Online door sounds (`GTAO_Script_Doors_Faded_Screen_Sounds`, 4,478) and the facility doors (2,472).
- **Audio scenes change the mix:** `START_AUDIO_SCENE` (564 scripts, 4,896 calls) with 1,136 different scene names, stopped with `STOP_AUDIO_SCENE` (572 scripts).
- **Scripts load their own sound banks:** `REQUEST_SCRIPT_AUDIO_BANK` (476 scripts, 3,889 calls, 443 bank names) and release them (`RELEASE_NAMED_SCRIPT_AUDIO_BANK` 378 scripts); streams (`LOAD_STREAM`, 315 scripts, 136 names) play long one-off audio.

## 27.2 The sound archives

Sizes of the 54 archives in `x64\audio\sfx` (**Verified**, rounded):

| Group | Archives | Size |
| --- | --- | --- |
| Interactive music (mission scores) | `INTERACTIVE_MUSIC` | 2.9 GB |
| Cutscenes | `CUTSCENE_MASTERED_ONLY` | 1.8 GB |
| Radio | `RADIO_01_CLASS_ROCK` to `RADIO_18_90S_ROCK` (17 stations), `RADIO_ADVERTS`, `RADIO_NEWS` | 0.1 to 0.5 GB each, about 4.5 GB together |
| Scripted speech (story dialogue) | `SS_AC`, `SS_DE`, `SS_FF`, `SS_GM`, `SS_NP`, `SS_QR`, `SS_ST`, `SS_UZ` (split by alphabet) | 8 MB to 732 MB |
| Ambient speech | `S_FULL_AMB_F`, `_AMB_M`, `_GAN`, `_SER`, `S_MINI_AMB`, `_GAN`, `_SER`, `S_MISC` | 0.26 to 0.69 GB each |
| Vehicles | `STREAMED_VEHICLES`, `_GRANULAR`, `_GRANULAR_NPC`, `_LOW_LATENCY` | 1 to 198 MB |
| World | `STREAMED_AMBIENCE`, `ONESHOT_AMBIENCE`, `ANIMALS`, `ANIMALS_NEAR`, `ANIMALS_FAR` | 1 to 66 MB |
| People | `PAIN`, `POLICE_SCANNER` | 41, 65 MB |
| Always in memory | `RESIDENT` | 108 MB |
| Script banks and streams | `SCRIPT`, `STREAMS` | 227, 403 MB |
| Other | `PROLOGUE`, `WEAPONS_PLAYER`, `DLC_GTAO` | 45, 4, 1 MB |

DLC packs add their own audio archives and config files, registered in `content.xml` ([archives and content](/docs/core/archives-and-content.md); 41 audio game-data entries, [R9.3](/docs/audio/music-and-radio.md)).

## 27.3 The config files

| File | Size (update) | Holds (**Known**) |
| --- | ---: | --- |
| `sounds.dat54.rel` | 1.3 MB | Sounds and sound sets: what plays when a name is asked for (wave, randomised lists, loops, envelopes) |
| `speech2.dat4.rel` | 709 KB | Voices and speech contexts |
| `game.dat151.rel` | 601 KB | Game audio objects: radio stations and tracks, vehicle and weapon audio settings, doors, static emitters, interiors, music events |
| `optamp.dat10.rel` | 259 KB | Amplitude data |
| `sp_sounds.dat54.rel` | 105 KB | Story-mode sounds |
| `dynamix.dat15.rel` | 65 KB | The mixer: scenes and their category changes |
| `curves.dat16.rel` | 17 KB | Volume and pitch curves |
| `audioconfig.dat4.rel`, `categories.dat22.rel` | 4 KB each | Global settings, the category tree |
| `dlc_gtao_*`, `dlctu_*` | | Online and title-update additions to the same kinds |

The number after `.dat` is the file's type and version. The engine looks sounds up by the hash of their name; scripts pass the names.

## 27.4 What scripts do

| Native | Scripts | Calls |
| --- | ---: | ---: |
| `PLAY_SOUND_FRONTEND` | 640 | 27,190 |
| `GET_SOUND_ID`, `RELEASE_SOUND_ID` | 507, 400 | 5,276, 4,183 |
| `STOP_SOUND` | 449 | 5,038 |
| `PLAY_SOUND_FROM_ENTITY` | 444 | 4,831 |
| `START_AUDIO_SCENE`, `STOP_AUDIO_SCENE`, `IS_AUDIO_SCENE_ACTIVE` | 564, 572, 489 | 4,896, 6,478, 4,718 |
| `REQUEST_SCRIPT_AUDIO_BANK`, `RELEASE_NAMED_SCRIPT_AUDIO_BANK`, `RELEASE_SCRIPT_AUDIO_BANK` | 476, 378, 372 | 3,889, 2,847, 563 |
| `HAS_SOUND_FINISHED` | 400 | 2,979 |
| `SET_STATIC_EMITTER_ENABLED` | 352 | 2,317 |
| `SET_AUDIO_FLAG` | 261 | 1,806 |
| `PLAY_SOUND_FROM_COORD` | 361 | 1,543 |
| `LOAD_STREAM`, `PLAY_STREAM_FRONTEND`, `STOP_STREAM` | 315, 293, 318 | 1,014, 1,078, 1,471 |
| `SET_VARIABLE_ON_SOUND` | 149 | 833 |
| `REQUEST_AMBIENT_AUDIO_BANK` | 76 | 176 |

The `AUDIO` namespace has 281 natives used by scripts, called 119,558 times in all.

**Pattern** (**Verified** pairing): a looping or long sound takes an ID from `GET_SOUND_ID`, is played with that ID, checked with `HAS_SOUND_FINISHED`, stopped with `STOP_SOUND` and its ID given back with `RELEASE_SOUND_ID`; one-shots pass −1 and need no ID. Banks are requested, polled until loaded (the request native returns true) and released at cleanup.

**Most used sound/set pairs** (literal calls): `Garage_Door_Open` / `GTAO_Script_Doors_Faded_Screen_Sounds` (2,734), `SELECT` / `HUD_FRONTEND_DEFAULT_SOUNDSET` (2,452), `Garage_Door_Close` (1,743), `Click_Special` / `WEB_NAVIGATION_SOUNDS_PHONE` (1,007), `CANCEL` (997), `NAV_UP_DOWN` (825), `hangar_doors_loop` (742), `NAV_LEFT_RIGHT` (673), the night-vision `Switch`, `On`, `Off` (626 each), `Event_Message_Purple` (345), `BACK` (316), `ERROR` (296).

## 27.5 What this means for modders

- **Menu sounds for a mod:** `PLAY_SOUND_FRONTEND(-1, "SELECT", "HUD_FRONTEND_DEFAULT_SOUNDSET", true)` and its `CANCEL`, `NAV_UP_DOWN`, `BACK`, `ERROR` siblings match the game's own menus.
- **Loops need an ID and cleanup:** take an ID, stop it and release it, or it plays on after the mod ends.
- **Release script banks and stop scenes at cleanup,** as Rockstar's scripts do in 378 and 572 scripts. A forgotten scene leaves the mix changed (radio ducked, world quiet).
- **New sounds** need new `.awc` containers and matching config entries (a `sounds.dat54` and possibly a `game.dat151`), packed as an add-on DLC ([archives and content](/docs/core/archives-and-content.md)). Replacing an existing wave keeps its config and is simpler.

## 27.6 Open questions

| Question | Where it goes |
| --- | --- |
| The number of sounds and sound sets in `sounds.dat54` | Second pass with a `.rel` reader |
| What each audio scene changes | Second pass, `dynamix.dat15` |
| `.awc` counts per archive | Second pass, list every archive |
| Speech archives and voices | R9.2 |

## 27.7 Test cards (story mode, a script mod)

1. **Menu sound.** Call `PLAY_SOUND_FRONTEND(-1, "SELECT", "HUD_FRONTEND_DEFAULT_SOUNDSET", true)`. Expected: the menu select click.
2. **Loop cleanup.** Play a looping sound with an ID, end the script without `STOP_SOUND`. Expected: it keeps playing, which shows why Rockstar stops and releases every ID.
