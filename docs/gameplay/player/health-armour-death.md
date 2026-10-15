# Health, armour, death and arrest

How much health peds and players have, where those numbers come from, the thresholds at which a ped is hurt, injured and dead, armour and how you get it back, and how scripts make peds tougher, weaker or immortal. Roadmap topic **R3.8** in the [roadmap](/ROADMAP.md). Builds on [weapons](/docs/gameplay/weapons/weapons.md) (damage) and [combat and perception](/docs/ai/combat-and-perception.md). What happens after the player dies or is busted (hospitals, police stations, the bill) is R6.2; ragdoll and falls are R2.3.

**How it was made.** Data files extracted from `common.rpf` and `update\update.rpf` with CodeWalker's library (as [`tools/rpf-cw.ps1`](/tools/README.md) does): `common:/data/pedhealth.meta` (no update copy), `update:/x64/data/metadata/pedpersonality.ymt` (converted to XML) and the update copy of `common:/data/pickups.meta`. Native use from the [PED](/scripting/native-usage/PED.md), [PLAYER](/scripting/native-usage/PLAYER.md) and [ENTITY](/scripting/native-usage/ENTITY.md) usage pages. Armour purchase read in `gunclub_shop` in the build-3725 decompile (commit `6c18d3e8b`). Build 1.0.3725.0 Legacy. Values and counts are **Verified**; what the engine does at each threshold is **Known** unless stated.

## Short version

- **Health has a floor of 100.** In `pedhealth.meta` a human ped is injured and dying at 100 health (`InjuredHealthThreshold` and `DyingHealthThreshold` are 100 in all five human configs). The usable health is what is above 100.
- **10 health configs.** `Strong` 200 (used by Michael, Franklin, Trevor, police, army, gangs), `Average` 175, `Weak` 150, `Armour` 200 plus 100 armour (used only by `SWAT`), `Animal` 150, `Shark` 200, `Humpback` 800, and `GULL`, `Fish` and `Rat` 10.
- **Each ped type picks a config through its personality.** Of the 96 personalities in `pedpersonality.ymt`, 27 use `Weak`, 26 `Average`, 20 `Strong`, 14 `Animal`, 4 `Shark`, and one each the rest.
- **So the player has 100 points to lose** (200 down to 100). A standard health pickup gives 100 (`REWARD_HEALTH`), a full refill; there is also a 50 reward, `REWARD_HEALTH_ENTER_VEHICLE` (**Known**: a pickup collected from a vehicle). Armour pickups give 100.
- **Armour is a separate pool**, usually up to 100 in story mode (`GET_PLAYER_MAX_ARMOUR`). Ammu-Nation sets armour to a percentage of that maximum rather than adding to it.
- **Scripts change health constantly:** `SET_ENTITY_HEALTH` in 504 scripts, `SET_PED_MAX_HEALTH` in 166, `SET_ENTITY_PROOFS` in 447, `SET_ENTITY_INVINCIBLE` in 646, `SET_PED_SUFFERS_CRITICAL_HITS` (headshot kills on or off) in 197, `ADD_ARMOUR_TO_PED` in 90.
- **"Injured" is the check scripts use for dead.** `IS_PED_INJURED` (903 scripts) is true at or below the injured threshold, before the death animation finishes; `IS_ENTITY_DEAD` is in 926 scripts.

## Where it lives

| File | What it holds | Count (build 3725) |
| --- | --- | --- |
| `common:/data/pedhealth.meta` | Health configs: default health and armour, and the fatigued, hurt, injured, dying and dog-takedown thresholds | 10 configs |
| `update:/x64/data/metadata/pedpersonality.ymt` | Ped personalities; each names a `HealthConfigHash` | 96 personalities (DLC packs add more through `PED_PERSONALITY_FILE`: 23 entries across the packs) |
| `common:/data/peds.meta` and `update:/x64/data/peds.ymt` | Each ped model names its personality (**Known**) | R14.2 |
| `common:/data/pickups.meta` (update copy) | Health and armour pickup rewards | `REWARD_HEALTH` 100, `REWARD_HEALTH_ENTER_VEHICLE` 50, `REWARD_ARMOUR` 100 |
| `common:/data/effects/peds/peddamage.xml`, `bloodfx.dat` | Blood and damage decals on peds | R13.3 |

### The health configs

Values from `pedhealth.meta`. Health and armour are entity units; "usable" is health above the dying threshold.

| Config | Health | Armour | Usable | Fatigued at | Hurt at | Injured / dying at | Dog takedown at | Fatal melee check | Personalities |
| --- | ---: | ---: | ---: | ---: | ---: | ---: | ---: | --- | ---: |
| `Strong` | 200 | 0 | 100 | 150 | 150 | 100 | 150 | no | 20 |
| `Average` | 175 | 0 | 75 | 137.5 | 125 | 100 | 150 | no | 26 |
| `Weak` | 150 | 0 | 50 | 125 | 135 | 100 | 150 | yes | 27 |
| `Armour` | 200 | 100 | 100 | 120 | 150 | 100 | 150 | no | 1 (`SWAT`) |
| `Animal` | 150 | 0 | 50 | 125 | 135 | 100 | 150 | no | 14 |
| `Shark` | 200 | 0 | 100 | 150 | 150 | 100 | 150 | no | 4 |
| `Humpback` | 800 | 0 | 700 | 150 | 150 | 100 | 150 | no | 1 |
| `GULL`, `Fish`, `Rat` | 10 | 0 | 8 | 3 | 4 | 2 | 2 | `GULL` only | 1 each |

**Verified:** the three player characters' personalities (`michael`, `franklin`, `trevor`) use `Strong`, as do `police`, `POLICE_FEMALE`, `army`, `security`, `merryweather`, `cult`, `BOUNCER`, `HILLBILLY` and the gangs (`BALLAS`, `FAMILY`, `VAGOS`, `BIKER`).

**Known (engine):**

- **Hurt** (`HurtHealthThreshold`): below it a ped can go into the hurt state (limping, holding the wound) and is more likely to stagger.
- **Fatigued** (`FatiguedHealthThreshold`): below it the ped moves and fights as tired.
- **Injured / dying** (100): at or below it the ped dies or goes into the writhe-on-the-ground state if writhe is allowed; `IS_PED_INJURED` turns true.
- **Dog takedown** (150): Chop can only take down a ped whose health is below it.
- **`MeleeCardinalFatalAttackCheck`**: whether a single melee hit from certain directions can kill (on for `Weak` and `GULL`).
- **Headshots** kill outright when the ped "suffers critical hits" (the default); `SET_PED_SUFFERS_CRITICAL_HITS(ped, false)` turns that off, which missions do for bosses and allies.

## Regeneration

**Known:** in story mode the player's health refills by itself, slowly, up to half the bar (150 of 200), and stops after damage until a delay passes. Armour never regenerates. Scripts tune it with `SET_PLAYER_HEALTH_RECHARGE_MULTIPLIER` (118 scripts, 318 calls; 0 turns it off) and `SET_PLAYER_HEALTH_RECHARGE_MAX_PERCENT` (114 scripts, 165 calls); both are mostly called by Online controllers.

## Armour

**Verified:** `gunclub_shop` (Ammu-Nation) never adds armour. Each body armour item has a percentage, and buying it sets armour to `floor(GET_PLAYER_MAX_ARMOUR / 100 × percentage)`, but only if your armour is below that. The shop's display code also checks the 20% and 40% steps. **Known:** the five armour items are 20, 40, 60, 80 and 100% (super light to super heavy), and the story maximum is 100. Pickups give 100 (`REWARD_ARMOUR`).

**Known (engine):** armour absorbs bullet and melee damage before health; fall, fire, explosion and drowning damage mostly go to health.

## Death and arrest

**Verified (counts):**

| Native | Scripts | Calls | Use |
| --- | ---: | ---: | --- |
| `IS_ENTITY_DEAD` | 926 | 139,873 | Is it dead (any entity) |
| `IS_PED_INJURED` | 903 | 77,901 | At or below the injured threshold: what scripts mean by "down" |
| `IS_PED_DEAD_OR_DYING` | 507 | 2,325 | Dead or in the death animation |
| `IS_PED_FATALLY_INJURED` | 403 | 418 | Will die, can't be revived |
| `IS_PLAYER_DEAD` | 440 | 2,133 | The player is dead (respawn not done yet) |
| `IS_PLAYER_BEING_ARRESTED` | 287 | 831 | The busted sequence is running |
| `REVIVE_INJURED_PED`, `RESURRECT_PED` | 265, 275 | 286, 280 | Bring a ped back (mostly Online) |
| `SET_PED_DIES_WHEN_INJURED` | 210 | 483 | Die at once at the threshold instead of writhing |
| `SET_PED_DIES_IN_WATER`, `SET_PED_DIES_INSTANTLY_IN_WATER`, `SET_PED_DIES_IN_SINKING_VEHICLE` | 191, 109, 121 | 592, 151, 342 | Drowning rules (R3.5) |
| `GET_PED_SOURCE_OF_DEATH`, `GET_PED_CAUSE_OF_DEATH` | 21, 12 | 36, 35 | Who or what killed it (mission checks, stats) |
| `SET_PED_DROPS_WEAPONS_WHEN_DEAD` | 48 | 110 | Weapon pickup on death |

**Known:** the player is busted only at a one-star wanted level, when a police officer reaches them on foot and they are not fighting back; at two stars and more, police shoot to kill. What the bust costs and where you go after is R6.2.

## How scripts change health

| Native | Scripts | Calls | Use |
| --- | ---: | ---: | --- |
| `SET_ENTITY_INVINCIBLE` | 646 | 36,609 | No damage at all |
| `SET_PLAYER_INVINCIBLE`, `SET_PLAYER_INVINCIBLE_BUT_HAS_REACTIONS` | 528, 403 | 2,286, 411 | The player version; the second still flinches |
| `GET_ENTITY_HEALTH` / `SET_ENTITY_HEALTH` | 545 / 504 | 1,961 / 3,825 | Read or set health (remember the 100 floor) |
| `SET_ENTITY_PROOFS` | 447 | 15,612 | Bullet, fire, explosion, collision, melee, steam, smoke and water proofs |
| `SET_PED_MAX_HEALTH`, `SET_ENTITY_MAX_HEALTH`, `GET_PED_MAX_HEALTH` | 166, 165, 115 | 410, 402, 568 | Tougher mission peds (bosses, allies) |
| `SET_PED_SUFFERS_CRITICAL_HITS` | 197 | 477 | Headshots kill or not |
| `GET_PED_ARMOUR`, `ADD_ARMOUR_TO_PED`, `SET_PED_ARMOUR`, `GET_PLAYER_MAX_ARMOUR` | 186, 90, 46, 21 | 369, 146, 147, 115 | Armour |
| `CLEAR_PED_BLOOD_DAMAGE`, `APPLY_PED_BLOOD_SPECIFIC`, `APPLY_PED_BLOOD_BY_ZONE` | 315, 136, 119 | 398, 3,202, 1,281 | Blood on the ped (looks only) |

**Verified (examples):** story missions raise ally and boss health with `SET_PED_MAX_HEALTH` and `SET_ENTITY_HEALTH` (`finale_heist2a`, `finale_heist2b`, `rural_bank_heist`, `carsteal4`, `franklin1`, `prologue1`) and give the player armour before big shootouts with `ADD_ARMOUR_TO_PED` (`fbi4`, `finale_heist2a`, `fbi1`, `fbi5a`, `docks_setup`).

## What this means for modders

- **Count from 100.** To give a ped "50% health", set `100 + 0.5 × (max − 100)`, not `0.5 × max`. Setting health to 100 or less kills the ped. Read the maximum with `GET_ENTITY_MAX_HEALTH`.
- **Tougher peds:** `SET_PED_MAX_HEALTH(ped, 500)` then `SET_ENTITY_HEALTH(ped, 500)`, plus `SET_PED_SUFFERS_CRITICAL_HITS(ped, false)` so a headshot doesn't skip it all. For a whole ped type, change its personality's `HealthConfigHash` or a config's values in `pedhealth.meta` (a data edit; it affects every ped that uses the config, including the player for `Strong`).
- **Stronger player:** raise the player ped's max health with `SET_PED_MAX_HEALTH` and `SET_ENTITY_HEALTH` after every respawn and character switch (both reset it, **Known**); `SET_PLAYER_MAX_ARMOUR` for armour.
- **Use `IS_PED_INJURED` for "is it down",** like Rockstar's scripts, rather than comparing health to 0.
- **Proofs and invincibility persist.** Turn them off when your mod stops; a ped left invincible keeps it until it is deleted.
- **Single player only.** Health, armour and damage in GTA Online are synced and checked; don't use these mods there.

## Open questions

| Question | Where it goes |
| --- | --- |
| The player's regeneration rate, delay and cap in numbers | Test card 2 |
| What exactly changes below the fatigued and hurt thresholds | In-game test |
| The 5 armour item percentages, read from the shop's data | Second pass: `gunclub_shop` item table |
| Which personalities each DLC pack adds and their health configs | Second pass with [`tools/dlc-scan.ps1`](/tools/README.md) |
| How armour splits damage between armour and health for each damage type | R3.1 second pass, in-game test |

## Test cards

1. **The floor.** In a script, print `GET_ENTITY_HEALTH(PLAYER_PED_ID())` and `GET_ENTITY_MAX_HEALTH`. Expected: 200 and 200 at full health. Fall from a height and print again: the ped is down when health reaches 100 or less.
2. **Regeneration.** Bring health to 110 with `SET_ENTITY_HEALTH`, stand still and log health every second. Expected: it climbs after a short delay and stops near 150.
3. **Armour purchase.** With 50 armour, buy the 40% item. Expected: nothing changes (you already have more). Buy the 60% item: armour becomes 60.
4. **Headshots.** Spawn two `Strong` peds, set `SET_PED_SUFFERS_CRITICAL_HITS(false)` on one, shoot each in the head with a pistol. Expected: the first dies at once, the second needs several shots.
