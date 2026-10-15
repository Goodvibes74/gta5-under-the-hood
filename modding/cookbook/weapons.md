# Cookbook: weapons

Weapon tuning, new weapons, giving and taking weapons. Part of the [mod-builder's cookbook](README.md).

## Systems it touches

| System | Guide |
| --- | --- |
| Weapon data and damage | [weapons](/docs/gameplay/weapons/weapons.md), [`weapons.meta`](/file-formats/weapons-meta.md) |
| Explosions and projectiles | [fire, explosions and projectiles](/docs/physics/fire-explosions-projectiles.md) |
| Health and armour | [health, armour and death](/docs/gameplay/player/health-armour-death.md) |
| Ragdoll reactions to hits | [ragdoll](/docs/entities/peds/ragdoll.md) |
| Pickups | [economy and pickups](/docs/gameplay/economy/economy-and-pickups.md) |
| Names | [text and names](/docs/entities/objects/text-and-names.md) |

## Natives and files

- Data: `weapons.meta` (damage, range, ammo, effects), `weaponcomponents.meta`, `weaponanimations.meta`, `loadouts.meta`.
- Give and take: `GIVE_WEAPON_TO_PED`, `GIVE_WEAPON_COMPONENT_TO_PED`, `REMOVE_WEAPON_FROM_PED`, `SET_CURRENT_PED_WEAPON`.
- Ammo: `SET_PED_AMMO`, `ADD_AMMO_TO_PED`.
- Damage tweaks at run time: `SET_PLAYER_WEAPON_DAMAGE_MODIFIER`, `SET_WEAPON_DAMAGE_MODIFIER`.

## Traps

- **Replacing base weapon data** goes stale on updates; add new weapons in a DLC pack.
- **Story missions give and take weapons;** a mod that changes the inventory mid-mission can break a mission's loadout checks.
- **Ragdoll and damage tuning interact:** a stronger bullet push changes how fights look ([ragdoll](/docs/entities/peds/ragdoll.md)).

## Minimal pattern: a weapon loadout

1. On a key or at a location, give the player a set of weapons and components.
2. Set ammo, select the main weapon.
3. Store the loadout in the mod's file so it can be restored after a mission takes weapons away.

**Quick test:** give the loadout, finish a mission that removes weapons, restore; everything returns with its components.
