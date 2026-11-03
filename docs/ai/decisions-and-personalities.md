# Decisions and personalities

What makes one ped brave and another a coward, a careful driver or a maniac, a gangster who squares up or a tourist who runs: the ped personalities in `pedpersonality.ymt`, their bravery types and flags, the per-character modifiers that make Michael, Franklin and Trevor different, and how these sit next to the combat profiles and decision makers covered in [combat and perception](/docs/ai/combat-and-perception.md). Roadmap topic **R17.3** in the [roadmap](/ROADMAP.md). Builds on [peds](/docs/entities/peds/peds.md) (each model names a personality), [health, armour, death and arrest](/docs/gameplay/player/health-armour-death.md) (the health config each personality picks) and [relationships and groups](/docs/ai/relationships-and-groups.md).

**How it was made.** `update:/x64/data/metadata/pedpersonality.ymt` extracted with CodeWalker's library (as [`tools/rpf-cw.ps1`](/tools/README.md) does), converted to XML, hashed names matched against the decompile's string literals, and every personality and bravery type read; the update copy of `common:/data/ai/combatbehaviour.meta` re-read for the player profiles; the 23 DLC `pedpersonality.meta` files checked. Build 1.0.3725.0 Legacy. Data is **Verified**; what each flag does in the engine is **Known** from its name and the community's tests.

## Short version

- **95 personalities** in the base file. DLC packs ship 23 `pedpersonality.meta` files, but they add weapon holster animations for new weapons, not new personalities.
- **A personality sets** bravery, agitation, criminality, health config (R3.8), weapon animations, ambient speech set, witness behaviour, agility, sex and humanity, gang/security/weird flags, affluence (poor 46, average 43, rich 6), tech savvy (high 60, low 35), which vehicle kinds the ped drives, attack strength, armour and health-regeneration efficiency, damage multipliers per weapon class, motivation, and driving ability and aggressiveness ranges.
- **The three players differ only here and in skills:** Michael wears armour better (×1.15) and does ×1.1 damage with handguns and rifles but regenerates slower (×0.9); Franklin has better stamina (×1.4) and ×1.1 SMG damage but worse armour (×0.85); Trevor regenerates faster (×1.15), has ×1.2 stamina and ×1.1 explosive damage, and is the only personality marked `IsWeird`.
- **18 bravery types** decide reactions. Each has a takedown probability and flags such as `BF_COWARDLY_FOR_SHOCKING_EVENTS`, `BF_REACT_ON_COMBAT`, `BF_CONFRONTATIONAL`, `BF_INTIMIDATE_PLAYER`, `BF_PURSUE_WHEN_HIT_BY_CAR`, `BF_DONT_SAY_PANIC_ON_FLEE`. `gang`, `cult`, `SWAT` and `army` are the bold ones (12 to 15 flags); `animal` and several civilian types have one or two. Personalities use `animal` 19 times, `gang` 14, `average` 11.
- **Driving is a range per personality:** 32 personalities drive with ability and aggressiveness anywhere from 0 to 10; others are narrower (ability 3 to 10 for 15, 1 to 6 for 8; aggressiveness 7 to 10 for 17, 1 to 5 for 6). Each spawned ped gets a value in its range (**Known**).
- **Agitation:** 40 personalities use the `default` agitated personality, 32 `Confront` (they square up when bumped or followed), 21 `none`.

## Where it lives

| File | What it holds | Count (build 3725) |
| --- | --- | --- |
| `x64/data/metadata/pedpersonality.ymt` | Personalities, bravery types, movement modes, unholster data | 95 personalities, 18 bravery types |
| DLC `common:/data/pedpersonality.meta` (`PED_PERSONALITY_FILE`) | Holster and unholster animations for DLC weapons | 23 files |
| `common:/data/ai/combatbehaviour.meta` | Combat profiles (`CombatInfo`) | 16 ([R3.2](/docs/ai/combat-and-perception.md)) |
| `common:/data/events.meta` | Decision makers and responses to events | 25 decision makers ([R3.2](/docs/ai/combat-and-perception.md)) |
| `common:/data/ai/agitatedpersonalities.meta`, `agitatedresponses.meta`, `agitatedtriggers.meta` | The agitation system (bumping, following, territory) | |
| `common:/data/ai/crimeinformation.meta`, `witnessinformation.meta` | What counts as a crime and who reports it | R3.7 |

### The player characters

| Field | Michael | Franklin | Trevor |
| --- | ---: | ---: | ---: |
| Health config | `Strong` | `Strong` | `Strong` |
| `ArmourEfficiency` | **1.15** | **0.85** | 1.0 |
| `HealthRegenEfficiency` | **0.9** | 1.0 | **1.15** |
| `StaminaEfficiency` | 1.0 | **1.4** | **1.2** |
| `HandGunDamageMod`, `RifleDamageMod` | **1.1**, **1.1** | 1.0, 1.0 | 1.0, 1.0 |
| `SmgDamageMod` | 1.0 | **1.1** | 1.0 |
| `ExplosiveDamageMod` | 1.0 | 1.0 | **1.1** |
| `IsWeird` | no | no | **yes** |
| Combat profile accuracy | 1.0 | 1.0 | 1.0 |

Their combat profiles (`MICHAEL`, `FRANKLIN`, `TREVOR` in `combatbehaviour.meta`) are identical: accuracy 1.0, fight proficiency 0.5, blind-fire chance 0.05, 9 behaviour flags. The differences between them are these personality numbers, the skill stats (R3.6) and the special abilities.

### The bravery types

| Bravery | Takedown probability | Flags | Typical users |
| --- | ---: | --- | --- |
| `default` | 0.9 | Pissed and pursue when hit by a car, horn, cowardly for shocking events, braver in a group, confront over territory (7) | The players, many civilians |
| `average` | 0.9 | As default plus react on combat, don't run from melee, can flee when hit by a car (9) | 11 personalities |
| `gang`, `cult` | 0.75 | Intervene in fights, watch car theft, intimidate the player, argumentative, confrontational, limit combatants, aggressive after running a ped over ... (15) | Gangs (14), the cult |
| `security` | 0.6 | Intervene, argumentative, confrontational, never forced to flee combat (10) | Guards |
| `army` | 0.5 | As gang without the limits (12) | Soldiers |
| `SWAT` | 0.3 | As army (12) | SWAT |
| `mission` | 0 | Three flags | Mission peds |
| `animal`, `rottweiler` and two more | 1.0 | One flag (pissed when hit by a car, or flee) | Animals (19 personalities) |
| Five unnamed civilian types | 0.75 to 1.0 | From 2 flags (cowardly, flee when hit) to 10 (react on combat, aggressive after running someone over) | Civilians |

**Known:** the takedown probability is how likely a stealth or melee takedown is to succeed against that ped (lower means harder: SWAT 0.3).

### Names of the hashed types (leftovers pass)

**Verified.** The XML converted from `pedpersonality.ymt` shows most names as hashes. Hashing candidate names with `joaat` (the names in the ped files and the docs, and patterns built from words such as `Timid`, `Bold` or `Law_Abiding`) now names all of them except some personalities:

- **All 18 bravery types:** `DEFAULT`, `Default_Female`, `AVERAGE`, `Average_Female`, `Bold`, `Bold_Female`, `Timid`, `Timid_Female`, `MISSION`, `Security`, `gang`, `cult`, `SWAT`, `ARMY`, `animal`, `ROTTWEILER`, `Dogaggressive` and `Dogtimid`. So the five unnamed civilian types are the male and female versions of `Bold` and `Timid`, plus `Average_Female` (and `Default_Female`). Personalities use `animal` 19 times, `gang` 14, `AVERAGE` 11, `Timid_Female` 10, `Bold` 9, `Average_Female` 7, `Timid` 5, `Bold_Female` 4 and `DEFAULT` 4.
- **Criminality, three types.** `Law_Abiding` is used by 60 personalities: the animals, the rich and old civilians, army, mission and bouncer personalities. Two hashes didn't resolve. `hash_958D8BA5` (27) covers the street gangs (`BALLAS`, `FAMILY`, `VAGOS`, `MARABUNTE`, `WEICHENG`), the poor and young civilians and `DEFAULT`. `hash_95242239` (9) covers `BIKER`, `HILLBILLY`, `CriminalMale` and `CriminalFemale`. Our reading is that they are a middle and a high criminality.
- **Personalities:** 69 of the 96 have a name now (the players, the gangs, the animals, the service and civilian groups such as `YOUNGAVERAGETOUGHMAN`, `OLDRICHMAN`, `SaltonFemale`); 27 are still only hashes.

**Motivation** (**Verified** values). Every personality has `MotivationMin` 0. `MotivationMax` is 10 for 79 personalities and 0 for 17: the five street gangs, `BIKER`, `ARMY`, `SWAT`, `Security`, `merryweather` and six unnamed ones. The 0 group is the peds who fight by role rather than mood, so our reading is that motivation is a 0 to 10 scale drawn per ped that only ordinary civilians get. No native reads or sets motivation (none in NativeDB has it in its name), so how the engine uses it is a test.

**Driving ranges.** The ranges in the short version are the only driving numbers in the file. Scripts override them per ped with `SET_DRIVER_ABILITY` (105 scripts, 121 calls), `SET_DRIVER_AGGRESSIVENESS` (118, 128) and `SET_DRIVER_RACING_MODIFIER` (113, 126), which take values from 0 to 1 (**Known**). How the personality's 0 to 10 range becomes that value, and how the value feeds the driving tasks (speed, overtaking, rule breaking), is engine behaviour, for the executable or a test ([driving AI](/docs/ai/driving-ai.md)).

## How it fits together

1. A ped model (`peds.ymt`) names a **personality**, a **combat info**, a **decision maker** and a **relationship group**.
2. The personality picks the **health config**, the **bravery**, the **agitation** set, driving and damage numbers.
3. When something happens near the ped, the engine raises an **event**; the **decision maker** chooses a response (flee, fight, watch, ignore), shaped by **bravery** flags ([R3.2](/docs/ai/combat-and-perception.md)).
4. If it fights, the **combat info** decides how; the **relationship group** decides against whom.
5. Scripts override any of it per ped (`SET_PED_COMBAT_ATTRIBUTES`, `SET_PED_FLEE_ATTRIBUTES`, `SET_BLOCKING_OF_NON_TEMPORARY_EVENTS`, `SET_PED_RELATIONSHIP_GROUP_HASH`).

## What this means for modders

- **Make the city braver or more cowardly** by editing bravery types (flags and takedown probability) in `pedpersonality.ymt`; every personality that uses the type changes. Making `default` drop `BF_COWARDLY_FOR_SHOCKING_EVENTS` makes ordinary people stand their ground.
- **Change driving** in the personalities' driving ranges (more aggressive traffic: raise `DrivingAggressivenessMin`), rather than per-ped natives every frame.
- **Rebalance the three heroes** with their personality numbers (armour, regeneration, damage multipliers) instead of invincibility hacks.
- **AI mods** that "make peds react realistically" mostly edit these files plus `events.meta` and `combatbehaviour.meta`; they apply to every ped of a type and cost nothing per frame.
- **Single player only.**

## Open questions

| Question | Where it goes |
| --- | --- |
| The names of the 5 unnamed civilian bravery types and the criminality types | Mostly answered in [names of the hashed types](#names-of-the-hashed-types-leftovers-pass): all 18 bravery types and `Law_Abiding`; two criminality hashes are still unnamed |
| What `IsWeird` changes for Trevor | In-game test; second pass |
| How motivation (`MotivationMin/Max`) is used | Partly answered in [names of the hashed types](#names-of-the-hashed-types-leftovers-pass): the values per personality; the engine use is a test |
| How the driving ranges map onto the driving tasks (R3.3, R17.6) | Third pass: scripts override the values (`SET_DRIVER_ABILITY` and two more), but the range-to-task link is the executable or a test |

## Test cards

1. **Armour.** Give each character 100 armour and take the same pistol hits. Expected: Michael's armour lasts longest, Franklin's shortest.
2. **Bravery.** Fire a gun in the air near civilians, then near a gang. Expected: civilians flee, gang members confront or fight.
3. **Driving.** Change a common civilian personality's aggressiveness to 10 to 10 and watch traffic. Expected: more lane-weaving and speeding.
