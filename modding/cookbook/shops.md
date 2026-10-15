# Cookbook: shops

A place where the player buys something in story mode. Part of the [mod-builder's cookbook](README.md).

## Systems it touches

| System | Guide |
| --- | --- |
| Money and pickups | [economy and pickups](/docs/gameplay/economy/economy-and-pickups.md) |
| Rockstar's shops and `shop_controller` | [story systems in an Online mode](/docs/online/story-systems-in-online-mode.md) |
| Clothes catalogue | [appearance and clothing](/docs/entities/peds/appearance-and-clothing.md) |
| Interiors | [interiors and IPLs](/docs/world/interiors-and-ipls.md) |
| Prompts and menus | [menus](menus.md), [UI and HUD](ui-and-hud.md) |
| Remembering purchases | [saves](/docs/core/saves.md) |

## Natives and files

- Money: the story characters' cash stats (`SP0_TOTAL_CASH`, `SP1_`, `SP2_`) with `STAT_GET_INT` / `STAT_SET_INT` ([economy](/docs/gameplay/economy/economy-and-pickups.md)).
- Prompt: `BEGIN_TEXT_COMMAND_DISPLAY_HELP` when near; a [menu](menus.md) for the stock.
- Blip on the map: `ADD_BLIP_FOR_COORD`, a sprite and name.
- Never the `MONEY` / `NET_GAMESERVER` natives: they are Online.

## Traps

- **Changing cash without checking the character:** each story character has its own cash stat.
- **Buying during a mission** can break mission state; check that no mission is running.
- **Purchases lost on reload:** keep them in the mod's own file per save slot.

## Minimal pattern

1. A blip and a trigger point; when the player is near and on foot, show a help prompt.
2. On the key: open the shop menu; each item shows its price.
3. On buy: check the current character's cash, subtract, give the item, write the purchase to the mod's file.
4. On load: read the file and give back what was bought.

**Quick test:** buy something, save, load the save; the purchase is still there and the money is gone once.
