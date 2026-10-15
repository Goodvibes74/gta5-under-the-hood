# Speech and dialogue

Where GTA V's spoken lines live and how scripts make peds talk: the scripted-speech archives (story dialogue, split into one container per mission or dialogue block), the ambient-speech voices (605 containers for 318 ped voices), the named character voices, ambient speech contexts, and the natives behind both. Roadmap topic **R9.2** in the [roadmap](/ROADMAP.md). Builds on [how audio is organised](/docs/audio/how-audio-is-organised.md) (R9.1: the archives) and [cutscenes and dialogue](/docs/gameplay/missions/cutscenes-and-dialogue.md) (R5.6: how a scripted conversation is built and played by `dialogue_handler`).

**How it was made.** Every `.awc` in the 16 speech-related archives of `x64\audio\sfx` (`SS_*`, `S_FULL_*`, `S_MINI_*`, `S_MISC`) was listed with [`tools/rpf-cw.ps1`](/tools/README.md) for build 1.0.3725.0 and grouped by name. Ambient speech calls were pulled from the decompile (commit `6c18d3e8b`) with `git grep` and their context names counted. Native counts from [native usage](/scripting/native-usage.md). Counts and names are **Verified**; what the name parts mean (`full`, `mini`, ethnicity) and how the engine picks a line are **Known**.

## 28.1 Short version

- **Story dialogue is in 8 archives, `SS_AC` to `SS_UZ`,** split by the first letters of the block name: 331 containers, one per mission or dialogue block (`fam1` to `fam4`, `arm1`, `arm3`, `eps1` ..., `fafj` ...). The biggest archive is `SS_FF` (83 containers, 732 MB).
- **Ambient speech is per voice:** `S_FULL_AMB_F`, `_AMB_M`, `_GAN`, `_SER` (250 containers) and `S_MINI_AMB`, `_GAN`, `_SER` (363) hold 605 voice containers for **318 voices**, named after the ped model and look (`a_m_m_beach_01_white_full_01`): "full" voices have the whole set of lines, "mini" voices a short set. By name: 267 white, 178 black, 97 Latino, 24 Korean, 20 Chinese, 19 Lost MC, 16 East LS and others.
- **Named characters are in `S_MISC`** (150 containers): Michael, Franklin and Trevor each have `_1_normal`, `_2_normal`, `_3_normal`, `_angry` and `_drunk` sets; Lamar, Amanda, Jimmy, Tracey, Dave, Steve, Lester, Simeon, Wade, Barry, Abigail and the strangers, Ammu-Nation clerks and others have their own.
- **Ambient lines are played by context name:** `PLAY_PED_AMBIENT_SPEECH_WITH_VOICE_NATIVE` (370 scripts, 1,121 calls), `PLAY_PED_AMBIENT_SPEECH_NATIVE` (291, 642), with 202 different contexts named literally. The commonest are `BOUNCER_EJECT_GENERIC` (742), `GENERIC_SHOCKED_HIGH`, `GENERIC_CURSE_MED`, shop lines (`SHOP_GREET`, `SHOP_SELL`, `SHOP_NO_COPS`, `SHOP_GOODBYE`), `KIFFLOM_GREET`, `BUMP`, `GENERIC_HI`.
- **Scripts give peds a voice** with `SET_AMBIENT_VOICE_NAME` (102 scripts, 98 different voices named) and `SET_PED_VOICE_GROUP` (104), and silence them with `STOP_PED_SPEAKING` (126) and `DISABLE_PED_PAIN_AUDIO` (175).
- **Conversations stop more than they start:** `STOP_SCRIPTED_CONVERSATION` is in 822 scripts and `IS_SCRIPTED_CONVERSATION_ONGOING` in 585, while starting is done in one place, `dialogue_handler` ([R5.6](/docs/gameplay/missions/cutscenes-and-dialogue.md)).

## 28.2 The speech archives

| Archive | Containers | Holds |
| --- | ---: | --- |
| `SS_AC`, `SS_DE`, `SS_FF`, `SS_GM`, `SS_NP`, `SS_QR`, `SS_ST`, `SS_UZ` | 47, 24, 83, 48, 45, 50, 33, 1 | Scripted speech: one container per dialogue block, named by the block (mission code) |
| `S_FULL_AMB_F`, `S_FULL_AMB_M` | 61, 107 | Full ambient voices, female and male |
| `S_FULL_GAN`, `S_FULL_SER` | 19, 63 | Full voices for gangs and services (police, medics ...) |
| `S_MINI_AMB`, `S_MINI_GAN`, `S_MINI_SER` | 180, 94, 89 | Short ("mini") voices |
| `S_MISC` | 150 | Named characters and special voices |
| `PAIN` | | Pain and effort sounds ([R9.1](/docs/audio/how-audio-is-organised.md)) |
| `POLICE_SCANNER` | | The scanner's reports (`PLAY_POLICE_REPORT`, 34 scripts) |

Each block name in `SS_*` matches the conversation block a mission loads by text block ([text labels](/docs/ui/text-labels.md)): the lines' subtitles and their audio share the root names.

## 28.3 Voices

**Ambient voice names** are built from the ped model, the look and the kind: `<model>_<ethnicity>_<full|mini>_<n>` (**Verified** pattern; meaning **Known**). The ped's voice comes from its model data and can be changed by script with `SET_AMBIENT_VOICE_NAME` or `SET_PED_VOICE_GROUP`.

**Main characters** in `S_MISC` (**Verified**):

| Character | Sets |
| --- | --- |
| Michael, Franklin, Trevor | `_1_normal`, `_2_normal`, `_3_normal`, `_angry`, `_drunk` |
| Lamar | `_1_normal`, `_2_normal`, `_drunk` |
| Amanda, Jimmy | `_normal`, `_drunk` |
| Tracey, Dave, Steve, Lester, Simeon, Wade, Barry, Abigail, Andy Moon, Baygor, Bill Binder, Beverly, Brad, Casey, Anton ... | one each |
| Bail-bond targets, base-jump pilots, Ammu-Nation, aircraft warnings, street performers | one each |

## 28.4 Ambient speech in scripts

| Native | Scripts | Calls |
| --- | ---: | ---: |
| `STOP_SCRIPTED_CONVERSATION` | 822 | 3,942 |
| `IS_SCRIPTED_CONVERSATION_ONGOING` | 585 | 2,507 |
| `PLAY_PED_AMBIENT_SPEECH_WITH_VOICE_NATIVE` | 370 | 1,121 |
| `PLAY_PED_AMBIENT_SPEECH_NATIVE` | 291 | 642 |
| `DISABLE_PED_PAIN_AUDIO` | 175 | 345 |
| `STOP_PED_SPEAKING` | 126 | 366 |
| `IS_AMBIENT_SPEECH_PLAYING` | 123 | 425 |
| `SET_PED_VOICE_GROUP` | 104 | 362 |
| `SET_AMBIENT_VOICE_NAME` | 102 | 281 |
| `IS_ANY_SPEECH_PLAYING` | 81 | 185 |
| `PLAY_PAIN` | 37 | 123 |
| `PLAY_POLICE_REPORT` | 34 | 51 |

The ambient call takes a ped, a **context** (a group of lines such as `GENERIC_HI`) and speech parameters (forced, shouted, interrupt ...); the engine picks a line from the ped's voice for that context. The `_WITH_VOICE` variant names the voice too, so any ped can speak any voice's lines. Of 1,200 literal calls, 742 are `BOUNCER_EJECT_GENERIC` (the club bouncers in Online); the rest spread over 201 contexts.

## 28.5 What this means for modders

- **Make a ped greet, curse or react** with `PLAY_PED_AMBIENT_SPEECH_NATIVE` and a context from 28.4; it uses the ped's own voice and works in story mode.
- **Give a ped a character's voice** with `PLAY_PED_AMBIENT_SPEECH_WITH_VOICE_NATIVE(ped, context, voice, params)`, for example a `S_MISC` voice name.
- **Replacing a line** means editing its `.awc` container in the right archive (same name, same line IDs); new dialogue needs new containers and speech config, packed as an add-on ([R9.1](/docs/audio/how-audio-is-organised.md)).
- **Stop speech at cleanup** (`STOP_PED_SPEAKING`, `STOP_SCRIPTED_CONVERSATION`) as Rockstar's scripts do.

## 28.6 Open questions

| Question | Where it goes |
| --- | --- |
| The list of contexts each voice has, from `speech2.dat4.rel` | Second pass with a `.rel` reader |
| Which block name maps to which mission, for all 331 containers | Second pass, with R5.1's mission table |
| The speech parameter names and what each does | Second pass, in-game test |

## 28.7 Test cards (story mode, a script mod)

1. **Greeting.** Make a nearby ped say `GENERIC_HI` with `SPEECH_PARAMS_FORCE`. Expected: a greeting in the ped's voice.
2. **Borrowed voice.** Play `GENERIC_CURSE_MED` on the same ped with a `S_MISC` voice such as `TREVOR_ANGRY` (the name is a guess from the container name). Expected: Trevor's voice from that ped, or nothing if the voice name is wrong.
