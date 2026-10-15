# Relationships and groups

Who likes and hates whom: the 40 default relationship groups and their rules in `relationships.dat`, which group each ped model starts in, how missions add their own groups and set relationships, and how player groups (followers, bodyguards, formations) work. Roadmap topic **R17.4** in the [roadmap](/ROADMAP.md). Builds on [combat and perception](/docs/ai/combat-and-perception.md) (R3.2), [peds](/docs/entities/peds/peds.md) (the `RelationshipGroup` on each model) and [native usage](/scripting/native-usage.md).

**How it was made.** `common:/data/relationships.dat` (no update copy) extracted with CodeWalker's library (as [`tools/rpf-cw.ps1`](/tools/README.md) does) and read in full. Model defaults counted in `peds.ymt` and the DLC `peds.meta` files. The relationship values and group names scripts pass were counted with `git grep -o` over the decompile (commit `6c18d3e8b`, literal arguments only). Native use from the [PED](/scripting/native-usage/PED.md) usage page. Build 1.0.3725.0 Legacy. Counts and data are **Verified**; how the engine applies them is **Known** unless stated.

## Short version

- **40 default groups** in `relationships.dat`: `PLAYER`, `CIVMALE`, `CIVFEMALE`, `COP`, `ARMY`, `SECURITY_GUARD`, `PRIVATE_SECURITY`, `FIREMAN`, `MEDIC`, four generic gangs (`GANG_1`, `GANG_2`, `GANG_9`, `GANG_10`), nine ambient gangs (`AMBIENT_GANG_LOST`, `_MEXICAN`, `_FAMILY`, `_BALLAS`, `_MARABUNTE`, `_CULT`, `_SALVA`, `_WEICHENG`, `_HILLBILLY`), `DEALER`, `HATES_PLAYER`, `AGGRESSIVE_INVESTIGATE`, animals (`HEN`, `WILD_ANIMAL`, `SHARK`, `COUGAR`, `DEER`, `CAT`, `DOMESTIC_ANIMAL`, `GUARD_DOG`), `PRISONER`, `NO_RELATIONSHIP`, `SPECIAL` and `MISSION2` to `MISSION8`.
- **Five levels:** the file uses `Respect`, `Like`, `Dislike` and `Hate`; anything not listed is neutral. In scripts the values are numbers: 0 companion, 1 respect, 2 like, 3 neutral, 4 dislike, 5 hate, 255 pedestrians (**Known** numbering; the counts below confirm the common ones).
- **Almost nobody hates the player by default.** Only `HATES_PLAYER`, `AGGRESSIVE_INVESTIGATE`, `PRISONER`, the animals (`WILD_ANIMAL`, `DEER`, `SHARK`, `COUGAR`, `DOMESTIC_ANIMAL`, `CAT`) and `HEN` (dislike) start against the player. Police are not hostile by default; the wanted level does that (R3.7).
- **Gangs only like themselves and their dogs:** every ambient gang `Like`s itself and `GUARD_DOG`, and nothing else. Cops respect medics, firemen, cops and the army and like security guards.
- **Most ped models start as civilians:** 690 models in `CIVMALE`, 275 in `CIVFEMALE`, 13 `WILD_ANIMAL`, 12 `security_guard`, 11 `COP`, 7 `AMBIENT_GANG_MEXICAN` and a few dozen in other groups.
- **Missions make their own groups:** `ADD_RELATIONSHIP_GROUP` in 225 scripts (names such as `ENEMIES` 29 times, `rgh_traffic` 19, `Player Group` 19, `BUDDIES` 13), `SET_RELATIONSHIP_BETWEEN_GROUPS` in 340 scripts with 4,251 calls. Of the literal values: respect 2,258, hate 1,022, like 370, pedestrians 323, neutral 65, companion 18, dislike 4.
- **Player groups** (followers): `SET_PED_AS_GROUP_MEMBER` 191 scripts, `IS_PED_GROUP_MEMBER` 193, `SET_GROUP_SEPARATION_RANGE` 151, `SET_GROUP_FORMATION_SPACING` 115, `TELL_GROUP_PEDS_IN_AREA_TO_ATTACK` 101.

## The default rules

`relationships.dat` lists the groups, then for each group the groups it feels something about. **Verified:**

| Group | Rules |
| --- | --- |
| `PLAYER` | Like `PLAYER` |
| `COP` | Respect `MEDIC`, `FIREMAN`, `COP`, `ARMY`; Like `SECURITY_GUARD` |
| `ARMY` | Like `ARMY`; Respect `COP` |
| `SECURITY_GUARD` | Like `COP`, `SECURITY_GUARD`, `GUARD_DOG` |
| `PRIVATE_SECURITY` | Like `PRIVATE_SECURITY`, `GUARD_DOG` |
| `FIREMAN` | Respect `MEDIC`, `FIREMAN`, `COP` |
| `MEDIC` | Like `MEDIC`; Respect `COP`, `ARMY`, `SECURITY_GUARD`, `FIREMAN` |
| `GANG_1`, `GANG_2`, `GANG_9`, `GANG_10` | Respect themselves |
| `AMBIENT_GANG_*` (9 gangs) | Like themselves and `GUARD_DOG` |
| `PRISONER` | Like `PRISONER`; Hate `PLAYER` |
| `HATES_PLAYER` | Hate `PLAYER`; Like `HATES_PLAYER`, `AGGRESSIVE_INVESTIGATE` |
| `AGGRESSIVE_INVESTIGATE` | Hate `PLAYER`; Like `HATES_PLAYER`, itself |
| `HEN` | Dislike `PLAYER` |
| `WILD_ANIMAL`, `DEER` | Hate the player, civilians, cops, guards, firemen, the generic and four ambient gangs, dealers, `HATES_PLAYER` (`DEER` also respects `DEER`) |
| `COUGAR` | Hate the player and almost every human group, including cops and army |
| `SHARK` | Hate `PLAYER` |
| `DOMESTIC_ANIMAL`, `CAT` | Hate `PLAYER`; Like civilians, cops, guards, firemen, gangs, dealers |
| `GUARD_DOG` | Like itself, civilians, guards, all nine ambient gangs, private security |
| `CIVMALE`, `CIVFEMALE`, `DEALER`, `NO_RELATIONSHIP`, `SPECIAL`, `MISSION2` to `8` | No rules (neutral to all) |

**Known:** these are the starting values for each new game session. Whether a ped attacks also depends on its combat and decision data, events (gunshots, seeing a weapon) and the wanted level; a neutral civilian still flees from gunfire.

## How missions use groups

| Native | Scripts | Calls | Use |
| --- | ---: | ---: | --- |
| `SET_PED_RELATIONSHIP_GROUP_HASH` | 438 | 1,742 | Put a ped in a group |
| `SET_RELATIONSHIP_BETWEEN_GROUPS` | 340 | 4,251 | Set how one group feels about another (one direction per call) |
| `GET_PED_RELATIONSHIP_GROUP_HASH`, `GET_RELATIONSHIP_BETWEEN_GROUPS` | 285, 228 | 524, 700 | Read them |
| `ADD_RELATIONSHIP_GROUP`, `DOES_RELATIONSHIP_GROUP_EXIST`, `REMOVE_RELATIONSHIP_GROUP` | 225, 224, 132 | 455, 467, 294 | Mission groups |
| `CLEAR_RELATIONSHIP_BETWEEN_GROUPS` | 12 | 41 | Reset to neutral |
| `SET_PED_AS_GROUP_MEMBER`, `IS_PED_GROUP_MEMBER`, `IS_PED_IN_GROUP`, `GET_GROUP_SIZE` | 191, 193, 157, 102 | | Followers |
| `SET_GROUP_SEPARATION_RANGE`, `SET_GROUP_FORMATION_SPACING`, `SET_GROUP_FORMATION` | 151, 115, 10 | | How far followers stray and how they line up |
| `SET_PED_GROUP_MEMBER_PASSENGER_INDEX` | 82 | 296 | Which seat a follower takes |
| `TELL_GROUP_PEDS_IN_AREA_TO_ATTACK` | 101 | 104 | Make a group's peds in an area attack |
| `GET_PED_GROUP_INDEX` | 20 | 45 | The player's group |

**The usual mission pattern (Known, matching the counts):** create `ENEMIES` (or a mission-named group) with `ADD_RELATIONSHIP_GROUP`, set it to hate the player's group both ways (two `SET_RELATIONSHIP_BETWEEN_GROUPS(5, ...)` calls), put allies in a `BUDDIES` or `Player Group` that respects the player (value 1, the most common literal), and remove the groups at cleanup.

## What this means for modders

- **Make enemies:** `ADD_RELATIONSHIP_GROUP("MY_ENEMIES", &hash)`, `SET_PED_RELATIONSHIP_GROUP_HASH(ped, hash)`, then `SET_RELATIONSHIP_BETWEEN_GROUPS(5, hash, GET_HASH_KEY("PLAYER"))` and the reverse. Remove the group when your mod stops.
- **Make allies:** respect (1) both ways, or make them followers with `SET_PED_AS_GROUP_MEMBER(ped, GET_PED_GROUP_INDEX(PLAYER_PED_ID()))`; set `SET_PED_NEVER_LEAVES_GROUP` if they shouldn't wander off (**Known**).
- **Change the world's politics** with a data edit to `relationships.dat` (gang wars: make two ambient gangs hate each other). It applies to every ped of those groups for the whole session.
- **Followers are limited:** the player's group holds a handful of members (**Known**: 7 followers besides the leader).
- **Single player only.**

## Open questions

| Question | Where it goes |
| --- | --- |
| The exact follower limit and what happens to the eighth | Test card 2 |
| Which mission groups persist between missions (global groups registered at boot) | Second pass: `standard_global_init` |
| How dislike (4) differs from hate (5) in behaviour | In-game test |
| How the wanted level overrides the `COP`–`PLAYER` relationship | R3.7 |

## Test cards

1. **Gang war.** `SET_RELATIONSHIP_BETWEEN_GROUPS(5, BALLAS, FAMILY)` and the reverse, then walk through Grove Street. Expected: Ballas and Families fight on sight.
2. **Followers.** Add eight peds to the player's group one by one. Note when the game stops accepting them.
3. **Default.** Spawn a `COP` model ped near you with no wanted level and aim at a civilian. Expected: no attack on you until a crime is reported.
