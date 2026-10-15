# Cookbook: spawning peds and giving them AI

Bodyguards, enemies, crowds, animals. Part of the [mod-builder's cookbook](README.md).

## Systems it touches

| System | Guide |
| --- | --- |
| Ped models and their data | [peds](/docs/entities/peds/peds.md) |
| Tasks and how scripts give them | [AI architecture](/docs/ai/ai-architecture.md) |
| Friends and enemies | [relationships and groups](/docs/ai/relationships-and-groups.md) |
| Reactions to the world | [perception and events](/docs/ai/perception-and-events.md), [decisions and personalities](/docs/ai/decisions-and-personalities.md) |
| Fighting | [combat and perception](/docs/ai/combat-and-perception.md) |
| Routes | [navigation](/docs/ai/navigation.md) |
| Limits and cost | [AI cost](/docs/ai/ai-cost-and-lod.md), [memory and pools](/docs/core/memory-and-pools.md) |

## Natives and files

- Spawn: `REQUEST_MODEL`, `HAS_MODEL_LOADED`, `CREATE_PED`, `SET_MODEL_AS_NO_LONGER_NEEDED`.
- Own it: `SET_ENTITY_AS_MISSION_ENTITY`.
- Side: `ADD_RELATIONSHIP_GROUP`, `SET_RELATIONSHIP_BETWEEN_GROUPS`, `SET_PED_RELATIONSHIP_GROUP_HASH`.
- Orders: `TASK_*` (one task), sequences (`OPEN_SEQUENCE_TASK` … `TASK_PERFORM_SEQUENCE`), `GET_SCRIPT_TASK_STATUS` to poll.
- Obedience: `SET_BLOCKING_OF_NON_TEMPORARY_EVENTS`, `SET_PED_COMBAT_ATTRIBUTES`, `SET_PED_FLEE_ATTRIBUTES`, `SET_PED_KEEP_TASK`.
- Data: `pedpersonality.ymt`, `combatbehaviour.meta`, `pedaccuracy.meta`.

## Traps

- **Re-giving a task every frame** restarts it; give once, poll.
- **Unblocked mission peds** walk off at the first gunshot within 100 m.
- **Too many armed peds** stall the main thread; keep fighters to 20 to 30 and lower ambient density.
- **Released peds freeze** unless they get a wander task and `SET_PED_KEEP_TASK`.
- **Far-away routes fail** until the navmesh is loaded (`ADD_NAVMESH_REQUIRED_REGION`).

## Minimal pattern: a bodyguard

1. Request the model and wait until loaded; create the ped beside the player; release the model.
2. Put it in the player's group (or a friendly relationship group), give a weapon, set combat attributes.
3. Block non-temporary events so it follows orders, but let combat in by giving it a combat task when the player is attacked.
4. Every frame: if the ped is dead or gone, stop; else poll its task.
5. On stop: give a wander task, `SET_PED_KEEP_TASK`, mark it no longer needed (or delete it if near and unseen).

**Quick test:** spawn the bodyguard, fire a gun nearby; it should stay with you until enemies attack.
