# Weapons

How GTA V defines a weapon: `weapons.meta` and its DLC additions, components and clips, damage and fall-off, range, fire rate, recoil and spread, ammo types and limits, aiming and lock-on; how scripts give, take and tune weapons; how Ammu-Nation decides what story mode can buy. Roadmap topic **R3.1** in the [roadmap](/ROADMAP.md).

**How it was made.** The vanilla weapon files in `update\update.rpf\common\data\` (`ai\weapons.meta`, `ai\weaponcomponents.meta`, `weaponarchetypes.meta`, `ai\weapontargetsequences.meta`) and the `dlc_patch` weapon files were read with `tools/rpf-cw.ps1`, the weapon files of the 89 DLC packs were scanned. Script use and the Ammu-Nation rules come from the build-3725 decompile (`gunclub_shop`, `standard_global_init`). Values and counts are **Verified**; what a field does in the engine is **Known** unless stated.

## 4.1 Short version

- **91 base weapons** are defined in `weapons.meta` as `CWeaponInfo` items, with 36 ammo types (`CAmmoInfo` and its rocket, projectile and thrown variants), 16 aiming profiles and 6 vehicle weapons. DLC weapons each come in their own `weapon<name>.meta` (the revolver, switchblade, heavy pistol ...).
- **A weapon is about 250 fields**: model and audio, damage type and fire type, wheel slot and group, ammo, clip, spread and recoil, headshot rules, damage and its fall-off with distance, force on peds, cars and helicopters, penetration, bullet speed, reload and fire rate, effects (muzzle flash, shells, tracers), camera and first-person offsets, lock-on and weapon range.
- **Clips and attachments are components** (`weaponcomponents.meta`): 42 clip definitions, scopes, suppressors, flashlights and model variants. A weapon's clip size comes from its fitted clip component.
- **Ammo is per type, not per weapon.** Weapons that share an ammo type share one pool; the pool's maximum is `AmmoMax` (250 for pistol, SMG, rifle and shotgun ammo; 20 for rockets; 25 for grenades and Molotovs).
- **Scripts don't change weapon stats.** They give and remove weapons, set ammo and components, and scale damage per weapon type (`SET_WEAPON_DAMAGE_MODIFIER`, 1,543 calls); the stats themselves are data.
- **Ammu-Nation in story mode** checks story progress: most weapons are always on sale, and about 15 unlock when a given mission is passed (the SNS pistol after `armenian2`, `lamar1` or `family3`; the special carbine after the Jewel Store Job).

## 4.2 Where weapons are defined

| File | What | Count |
| --- | --- | --- |
| `update.rpf\common\data\ai\weapons.meta` | Base weapons, ammo, aiming profiles, vehicle weapons | 91 `CWeaponInfo`, 36 `CAmmoInfo` (+3 projectile, 6 rocket, 8 thrown), 16 `CAimingInfo`, 6 `CVehicleWeaponInfo` |
| `update.rpf\common\data\ai\weaponcomponents.meta` | Components | 42 clips, 7 scopes, 5 suppressors, 3 flashlights, 45 variant models, 8 reload data, 3 plain components, 2 swap data |
| `update.rpf\common\data\weaponarchetypes.meta` | Weapon models (archetypes) | |
| `update.rpf\common\data\ai\weaponanimations.meta` | Which animation sets each weapon uses per movement style | |
| `update.rpf\common\data\ai\weapontargetsequences.meta` | Target sequences for lock-on | |
| `update.rpf\dlc_patch\<pack>\common\data\ai\weapon<name>.meta` | Later fixes and weapons added by early Online packs (`weaponrevolver`, `weaponswitchblade`, `weaponheavypistol`, `weaponspecialcarbine`, `weaponbullpuprifle`, `weaponsnspistol`, `weaponhominglauncher`, `weaponproxmine`, `weaponsnowball`, `weaponpipebomb` ...) | |
| `update.rpf\dlc_patch\<pack>\common\data\shop_weapon.meta` | Shop entries for those packs | |
| DLC packs | Each pack's own weapon files | see 4.8 |
| `common.rpf\data\thrownweaponinfo.xml` | Throwing parameters | |

**How the entries are split** across the 91 base weapons (**Verified**):

| Field | Values |
| --- | --- |
| `DamageType` | `BULLET` 22, `MELEE` 22, `EXPLOSIVE` 16, `UNKNOWN` 13, `NONE` 6, `ELECTRIC` 4, `FIRE` 2, `SMOKE` 2, and one each of `WATER_CANNON`, `FIRE_EXTINGUISHER`, `FALL`, `BARBED_WIRE` |
| `FireType` | `INSTANT_HIT` 22 (bullets are hit-scan), `MELEE` 22, `PROJECTILE` 20 (rockets, grenades, thrown), `NONE` 22, `DELAYED_HIT` 3, `VOLUMETRIC_PARTICLE` 2 (fire extinguisher, petrol can) |
| `Group` | `UNARMED` 16, `THROWN` 8, `HEAVY` 8, `MELEE` 6, `PISTOL` 4, `SHOTGUN` 4, `SMG` 3, `RIFLE` 3, `SNIPER` 2, `MG` 2, plus stun gun, petrol can, parachute, night vision, fire extinguisher, digiscanner |

So "weapons" also covers non-weapons the player can hold: the parachute, night vision, the digiscanner, the petrol can, and the "weapons" used for falls, barbed wire and water cannons when the game assigns damage.

## 4.3 How a bullet does damage

For an instant-hit weapon, one shot works like this (**Known** model, field names **Verified**):

1. The game fires `BulletsInBatch` rays (1 for most guns, 8 for shotguns) with `BatchSpread`, plus spread from `AccuracySpread` and recoil (`RecoilAccuracyMax`, `RecoilErrorTime`, `RecoilRecoveryRate`).
2. A ray travels up to `WeaponRange` and passes through materials up to its `Penetration` against each material's penetration resistance ([engine guide 5](/docs/physics/collision-and-materials.md#53-materials)).
3. Damage starts at `Damage` and falls off linearly between `DamageFallOffRangeMin` and `DamageFallOffRangeMax` down to `DamageFallOffModifier` times the damage.
4. It is multiplied by the headshot modifier (`HeadShotDamageModifierPlayer`, 18 on most guns, 20 on pistols; separate AI values, and headshots only count within `Min/MaxHeadShotDistance`), the limb modifier, and `LightlyArmouredDamageModifier` against armour.
5. Force pushes the target: `Force`, `ForceHitPed`, `ForceHitVehicle`, `ForceHitFlyingHeli`, plus per-bone overrides front and back.
6. In Online, `NetworkPlayerDamageModifier` and `NetworkPedDamageModifier` scale it again.

**Vanilla numbers for the main guns** (**Verified**, current `update.rpf` file):

| Weapon | Damage | Range | Time between shots (s) | Fall-off from / to (m) | Fall-off to | Pellets | Lock-on range |
| --- | --- | --- | --- | --- | --- | --- | --- |
| Pistol | 26 | 120 | 0.37 | 40 / 120 | 0.3 | 1 | 55 |
| Combat pistol | 27 | 120 | 0.37 | 40 / 120 | 0.3 | 1 | 55 |
| .50 pistol | 51 | 120 | 0.52 | none | | 1 | 55 |
| Micro SMG | 21 | 120 | 0.10 | 40 / 120 | 0.3 | 1 | 55 |
| SMG | 22 | 120 | 0.118 | 40 / 120 | 0.3 | 1 | 55 |
| Assault rifle | 30 | 120 | 0.158 | 47.5 / 120 | 0.3 | 1 | 65 |
| Carbine rifle | 32 | 120 | 0.135 | 47.5 / 120 | 0.3 | 1 | 65 |
| Advanced rifle | 34 | 120 | 0.12 | 47.5 / 120 | 0.3 | 1 | 65 |
| MG | 40 | 120 | 0.137 | 47.5 / 120 | 0.3 | 1 | 65 |
| Combat MG | 45 | 120 | 0.108 | 47.5 / 120 | 0.3 | 1 | 65 |
| Pump shotgun | 29 per pellet | 40 | 0.8 | 10 / 40 | 0.3 | 8 | 35 |
| Sawn-off shotgun | 40 per pellet | 40 | 1.0 | 10 / 40 | 0.3 | 8 | 35 |
| Sniper rifle | 101 | 1,500 | 1.567 | none | | 1 | 50 |
| Heavy sniper | 216 | 1,500 | 1.2 | none | | 1 | 50 |
| Minigun | 30 | 120 | 0.02 | 57.5 / 120 | 0.3 | 1 | 80 |
| RPG | explosion | 85 | 0.8 | | | 1 | 80 |

Two things follow: every rifle and pistol in vanilla has the same 120 m range, and beyond about 40 to 50 m every bullet loses damage until it does 30 percent at 120 m. Rockets and grenades do their damage through the explosion they trigger (`Explosion` field, R2.5).

## 4.4 Ammo

Ammo types and their pool limits (`AmmoMax`, **Verified**):

| Ammo | Max | Ammo | Max |
| --- | --- | --- | --- |
| `AMMO_PISTOL` | 250 | `AMMO_SNIPER` | 250 |
| `AMMO_SMG` | 250 | `AMMO_MG` | 500 |
| `AMMO_RIFLE` | 250 | `AMMO_MINIGUN` | 250 |
| `AMMO_SHOTGUN` | 250 | `AMMO_RPG`, `AMMO_STINGER`, `AMMO_GRENADELAUNCHER` | 20 |
| `AMMO_GRENADE`, `AMMO_STICKYBOMB`, `AMMO_MOLOTOV`, `AMMO_SMOKEGRENADE`, `AMMO_BZGAS`, `AMMO_FLARE` | 25 | `AMMO_PETROLCAN` | 4,500 |
| `AMMO_STUNGUN` | 250 | `AMMO_FIREEXTINGUISHER` | 2,000 |

The Mk II special rounds (`_FMJ`, `_HOLLOWPOINT`, `_INCENDIARY`, `_ARMORPIERCING`, `_TRACER`, `_EXPLOSIVE`) have their own pools (240, 360 for tracers, 80 for sniper rounds, 40 for explosive). The pool is shared, so a pistol and a combat pistol draw from the same 250 rounds. Story stats and Online rank can raise the carried maximum (**Known**, R3.6).

## 4.5 Components, clips and tints

`weaponcomponents.meta` defines what can be attached (**Verified** counts in 4.2). A clip component sets `ClipSize` (pistol 12, extended 16; assault rifle 30, extended 60; MG 54 ...), a suppressor changes sound and range, a scope sets the zoom and camera, a flashlight adds a light, and variant models swap the weapon's look (finishes, Mk II camos). Scripts fit them with `GIVE_WEAPON_COMPONENT_TO_PED` and colour them with tint indexes.

## 4.6 Aiming and lock-on

`CAimingInfo` (16 profiles) sets the aiming camera and how the aim is offset per stance. `LockOnRange` is the soft-lock distance for controller aim assist (35 for shotguns, 55 for pistols and SMGs, 65 for rifles, 80 for the minigun and RPG). `AccurateModeAccuracyModifier` and `RunAndGunAccuracyModifier` scale spread when aiming down sights or moving. Homing weapons (homing launcher, Stinger) use target sequences from `weapontargetsequences.meta`. How aim assist itself works is in the frontend settings and is part of R3.2.

## 4.7 What scripts do with weapons

117 different `WEAPON::` natives appear in Rockstar's scripts. The most used (**Verified** counts):

| Native | Calls | Use |
| --- | --- | --- |
| `HAS_PED_GOT_WEAPON` | 6,675 | Check before giving or selecting |
| `SET_CURRENT_PED_WEAPON` | 5,577 | Put a weapon in hand (unarmed for cutscenes) |
| `GIVE_WEAPON_TO_PED` | 3,909 | Mission loadouts, shop purchases |
| `HAS_PED_GOT_WEAPON_COMPONENT` | 3,700 | Shops and loadout saves |
| `GET_CURRENT_PED_WEAPON` | 3,017 | |
| `GET_AMMO_IN_PED_WEAPON` | 2,970 | |
| `IS_WEAPON_VALID` | 2,346 | Is this hash a weapon in this build |
| `SET_WEAPON_DAMAGE_MODIFIER` | 1,543 | Scale one weapon type's damage (Online balance, missions) |
| `SET_PED_AMMO` | 1,286 | |
| `REMOVE_WEAPON_FROM_PED` | 1,037 | |
| `GIVE_WEAPON_COMPONENT_TO_PED` | 927 | |
| `GET_MAX_AMMO` / `GET_MAX_AMMO_IN_CLIP` | 594 / 462 | |
| `SET_PED_INFINITE_AMMO` | 305 | Mission set pieces |
| `REQUEST_WEAPON_ASSET` / `HAS_WEAPON_ASSET_LOADED` | 253 / 260 | Stream a weapon model before giving it |

The snapshot a mission takes at each checkpoint ([guide 3](/docs/gameplay/missions/mission-anatomy.md#36-checkpoints-retry-and-skip)) records every weapon, component and tint of all three characters, plus the `sp<n>_weap_purch_*` stats for what was bought.

## 4.8 DLC weapons

All 89 vanilla DLC packs were scanned (**Verified**). 33 packs carry weapon files (231 files), defining **246 more `CWeaponInfo` entries**: 69 hand weapons, 12 of them Mk II versions (`WEAPON_*_MK2`), and 177 vehicle weapons (`VEHICLE_WEAPON_*`, the turrets, missiles and cannons of the Online vehicles). Next to them are 172 plain components, 106 clips, 17 scopes, 15 suppressors, 5 flashlights, 16 variant models, 11 aiming profiles, 54 vehicle-weapon infos and 67 ammo entries (mostly rockets and projectiles for vehicle weapons).

The packs with the most: `mpchristmas2018` (Arena War, 40), `mpchristmas2017` (Doomsday, 36), `mpgunrunning` (29, where the Mk II weapons start), `mpsmuggler` (28), `mpbattle` (22), `mpheist4` (12), `mpheist3` (9), `mpheist` (8).

The DLC hand weapons include the revolvers (`REVOLVER`, `DOUBLEACTION`, `NAVYREVOLVER`), the newer rifles (`MILITARYRIFLE`, `HEAVYRIFLE`, `TACTICALRIFLE`, `PRECISIONRIFLE`, `BATTLERIFLE`), the Up-n-Atomizer family (`RAYPISTOL`, `RAYCARBINE`, `RAYMINIGUN`), launchers (`COMPACTLAUNCHER`, `EMPLAUNCHER`, `SNOWLAUNCHER`), mines and bombs (`PROXMINE`, `PIPEBOMB`), and tools that are "weapons" to the engine (`FLASHLIGHT`, `METALDETECTOR`, `HACKINGDEVICE`, `HANDCUFFS`, `FERTILIZERCAN`, `GARBAGEBAG`, `NEWSPAPER`). With the 91 base entries the game defines about 337 weapon entries; `WeaponLimitsAdjuster` raises the pool to 512 (4.10) so add-on weapons still fit.

## 4.9 Ammu-Nation in story mode

`gunclub_shop` runs every Ammu-Nation. In story mode most weapons are always listed; about 15 check whether a mission is passed, using the "mission completed" value of the story save ([guide 2](/docs/gameplay/missions/story-flow.md#23-where-the-flow-lives-in-the-save)) (**Verified**):

| Weapon | Unlocks after |
| --- | --- |
| Bottle, hammer | `armenian2` (Repossession) |
| SNS pistol | `armenian2`, `lamar1` or `family3` |
| Railgun | `exile1` |
| Hatchet, antique dagger, vintage pistol | `trevor1` (hatchet only with a condition still to read) |
| Heavy pistol | `fbi1` |
| Gusenberg | mission 28 (`finale_credits` in the table; to check) |
| Bullpup shotgun | `docks_heistA` or `fbi4` |
| .50 pistol | `fbi5A` |
| Musket, marksman pistol | `solomon1` |
| Bullpup rifle | `finale_heist2A` or `finale_heist2B` |
| Special carbine | `jewelry_heist` |

In Online the same script uses rank, crew and DLC tunables instead (`GSM_LOCK_RNK`, `GSM_LOCK_CREW`, `GSM_LOCK_FM`, `GSM_LOCK_SCLUB` labels). Purchases are kept in per-character stats (`sp0_weap_purch_0`, `sp0_weap_addon_purch_*`, `sp0_weap_tint_purch_*`).

## 4.10 Engine limits for add-on weapons

The engine has a fixed pool for weapon definitions and components. Community plug-ins such as WeaponLimitsAdjuster raise it (for example to 512 weapon infos and 1,024 components), so many add-on weapons fit (**Known**).

## 4.11 What this means for modders

- **Change weapons through data, and merge.** A balance change belongs in an add-on pack's own `weapons*.meta`, never in a replaced base `weapons.meta`, which freezes the game's weapon list at the build it was copied from. The diff method used here shows exactly what a replacement changes.
- **Per-mission tuning at run time** uses `SET_WEAPON_DAMAGE_MODIFIER`, `SET_PED_INFINITE_AMMO` and clip and ammo natives, as Rockstar does; they reset with the session.
- **Shared ammo pools** matter for loot and shop design: selling "rifle ammo" fills every rifle.
- **Weapon overhauls change AI fights.** Realism mods that raise ranges (rifles to 350 to 400 m) and fire rates make NPC gunfights reach farther and hit harder than vanilla tuning assumes. Test spawn distances and armour against the overhauls players commonly install.
- **Story unlocks are readable.** A mod can tell the player why a gun isn't on sale by reading the same mission-completed values `gunclub_shop` reads.

## 4.12 Open questions

| Question | Where it goes |
| --- | --- |
| Which mod installed the weapon overhaul (and the other 93 replaced files) | Ask the user; R10.1 |
| The hatchet's extra condition, and whether the Gusenberg really waits for `finale_credits` | R3.1 second pass |
| How story stats and Online rank change `AmmoMax` | R3.6 |
| Explosion damage and radius per explosive (`explosion.meta`) | R2.5 |
| How aim assist and lock-on work for the player versus AI | R3.2 |
