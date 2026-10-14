# 4. Your first data edit

Change how one car drives by editing one value in `handling.meta`, through OpenIV's mods folder so the original archive stays untouched. No programming. Part of the [modding path](README.md). Background: [archives and content](/docs/core/archives-and-content.md), [vehicle handling](/docs/physics/vehicle-handling.md), [`handling.meta` format](/file-formats/handling-meta.md).

## Short version

- The current base `handling.meta` lives in `update\update.rpf\common\data\handling.meta` (**Verified**, build 3725). It holds 254 `CHandlingData` entries, one per base-game handling name; DLC cars have their own copies inside their packs.
- Install OpenIV's ASI and mods folder, copy `update.rpf` into `Mods\`, and edit the copy. Never the original.
- Change **one** field for **one** car, test, then change more.
- The edited copy goes stale after every game update; write down what you changed so you can redo it on a fresh copy.

## 1. Set up OpenIV's mods folder

1. Install OpenIV from https://openiv.com and point it at your game folder (GTA V, Windows).
2. In OpenIV: Tools, "ASI Manager". Install **ASI Loader** (if it says ScriptHookV's is already there, keep that one) and **OpenIV.ASI**. Add `OpenIV.asi` to your file list from step 3.
3. Turn on **Edit mode** (button in the toolbar). OpenIV asks you to confirm; it will only write into `Mods\`.

## 2. Copy the archive into the mods folder

1. In OpenIV, browse to `update\update.rpf`.
2. Right-click `update.rpf`, **Copy to "mods" folder**. OpenIV creates `Mods\update\update.rpf` (about 2 GB in build 3725, **Verified**; make sure the drive has room).
3. From now on, open `Mods\update\update.rpf`, never `update\update.rpf`. OpenIV shows which one you're in at the top of the window.

## 3. Find your car's entry

1. Inside `Mods\update\update.rpf`, open `common\data\handling.meta` (OpenIV's built-in text editor opens it).
2. Search for the car's handling name, for example `<handlingName>ADDER</handlingName>`. Most handling names match the model name, upper case; when they don't, the model's `vehicles.meta` entry names its `handlingId` ([vehicle handling](/docs/physics/vehicle-handling.md)).
3. Everything until the next `</Item>` is that car's handling.

## 4. Change one value

Pick a field whose effect is easy to feel:

| Field | What it changes (**Known**) | Try |
| --- | --- | --- |
| `fInitialDriveForce` | Acceleration | Double it |
| `fInitialDriveMaxFlatVel` | Top speed (roughly km/h) | Add 50 |
| `fTractionCurveMax` | Grip in corners | Add 0.5 |
| `fMass` | Weight in kg | Halve it (it now loses every crash) |

Write the old value in your notes, change it, save. OpenIV writes the file back into the archive copy.

## 5. Test it

1. Start the game (story mode, BattlEye off).
2. Spawn the car (a trainer, or find one on the street) and drive.
3. Now change it back, or make it extreme, and feel the difference. One change at a time is how you learn what a field does.

If nothing changed: check `OpenIV.log` in the game folder (does it mention the mods folder?), check that you edited the copy in `Mods\`, and check that you edited the right entry (DLC cars take their handling from their own pack, not from this file).

## Add-on instead of replacement (later)

A replacement edit like this one changes an existing car. To add a **new** car without touching Rockstar's files, mods ship as add-on DLC packs: a `dlc.rpf` in `update\x64\dlcpacks\<name>\` (in the mods folder) plus a `dlcpacks:/<name>/` line in `dlclist.xml`. Add-on packs survive game updates; replacement copies do not. How packs, `setup2.xml` and `content.xml` fit together: [archives and content](/docs/core/archives-and-content.md).

## After a game update

The game will keep reading your old `Mods\update\update.rpf`, which hides every change the update made to that archive ([surviving updates](/docs/core/surviving-updates.md)). The fix: delete the copy, copy the new `update.rpf` again, and redo your edits from your notes. This is why the notes matter.

## Exercises

1. Make the same car ten times heavier. What happens when it hits a bus?
2. Find two cars that share one handling name. (Hint: search for a `handlingName` and then search `vehicles.meta` for `handlingId` values.)
3. Open `common\data\ai` in the same archive and find a file whose name tells you what it tunes. What would you test to see its effect?
4. Read the [weapons guide](/docs/gameplay/weapons/weapons.md) and make the pistol's clip twice as big, the same way.

Next: [5. Your first C# mod](05-first-csharp-mod.md).
