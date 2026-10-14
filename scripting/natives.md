# 05 Native functions

Natives are the game's built-in script functions: 6,701 of them in this build, grouped into namespaces (`PLAYER`, `PED`, `VEHICLE`, `ENTITY`, `HUD`, `MISC`, ...). Rockstar's own missions are written with them. Every library is a layer over natives, and anything a library doesn't wrap, you can still do with a native.

> **Sources:** natives from NativeDB (`natives.json`, alloc8or/gta5-nativedb-data; commit in [`../reference/natives/README.md`](https://nativedb.dotindustries.dev/gta5/natives)). C# calls compile-checked against `ScriptHookVDotNet3.dll` 3.7.0.189. Lua names from `LUA.asi`. Details: Where everything comes from.

Reference: [`../reference/natives/README.md`](https://nativedb.dotindustries.dev/gta5/natives) (one page per namespace). Online, the same data with search: https://nativedb.dotindustries.dev

## Reading a native's entry

```c
Vehicle CREATE_VEHICLE(Hash modelHash, float x, float y, float z, float heading, BOOL isNetwork, BOOL bScriptHostVeh, BOOL p7)  // 0xAF35D0D2583051B0
```

| Part | Meaning |
| --- | --- |
| `Vehicle` | Return type: here a vehicle handle (an `int`) |
| `CREATE_VEHICLE` | Name, in the `VEHICLE` namespace |
| `Hash modelHash` | A model hash. Get it from a name with `GET_HASH_KEY("adder")` |
| `BOOL isNetwork` | For online. Always `false` in single player |
| `p7` | An unknown parameter. Usually pass `false` or `0` |
| `0xAF35...` | The 64-bit native hash, which is how the game identifies it. It never changes between builds |
| `build 1604` (shown under some natives) | The first game build that has it. This install is build 3725 |
| `old names` | What it used to be called. Old mods and the Lua plugin use these |

Pointer parameters (`int*`, `float*`, `Vector3*`, `Any*`) are outputs: the native writes into them.

## Finding the native you need

1. **Check the library first.** SHVDN wraps most common natives as properties (`ped.Health` is `GET_ENTITY_HEALTH` / `SET_ENTITY_HEALTH`). Search [`../reference/SHVDN3/`](https://github.com/scripthookvdotnet/scripthookvdotnet).
2. **Guess the namespace:** players `PLAYER`, people `PED`, cars `VEHICLE`, any entity `ENTITY`, AI orders `TASK`, on-screen text and blips `HUD`, drawing `GRAPHICS`, models and loading `STREAMING`, camera `CAMERA`, keys and buttons `PAD`, weather, time and everything else `MISC` / `CLOCK`.
3. **Search the reference** for a word: the [NativeDB website](https://nativedb.dotindustries.dev/gta5/natives), or a local copy of the native list with `grep -ri "wanted"`.
4. **Read the description and test in game.** Descriptions are community research: mostly right, sometimes vague.

## Calling natives from C#

```csharp
using GTA.Native;

// No return value
Function.Call(Hash.SET_PED_CAN_RAGDOLL, Game.Player.Character, false);

// With a return value: give the type
bool swimming = Function.Call<bool>(Hash.IS_PED_SWIMMING, Game.Player.Character);
Vector3 coords = Function.Call<Vector3>(Hash.GET_ENTITY_COORDS, Game.Player.Character, true);

// Output parameter (a pointer in the reference): OutputArgument
using (var groundZ = new OutputArgument())
{
    if (Function.Call<bool>(Hash.GET_GROUND_Z_FOR_3D_COORD, x, y, 1000f, groundZ, false, false))
        z = groundZ.GetResult<float>();
}

// A native missing from the Hash enum: cast its 64-bit hash
Function.Call((Hash)0xD80958FC74E988A6);
```

Arguments: SHVDN converts `int`, `float`, `bool`, `string`, entities (`Ped`, `Vehicle`, `Prop`, `Entity`, `Blip`, `Camera`) and enums. `Vector3` arguments are passed as three floats (`pos.X, pos.Y, pos.Z`) because natives take them that way.

The `Hash` enum has a value for every native SHVDN knows, named as in the reference. Full example: [`examples/03_Natives.cs`](/examples/03_Natives.cs).

## Calling natives from C++

`natives.hpp` has a function for every native, in a C++ namespace per native namespace:

```cpp
Ped player = PLAYER::PLAYER_PED_ID();
Vector3 pos = ENTITY::GET_ENTITY_COORDS(player, TRUE);
Hash model = MISC::GET_HASH_KEY("adder");

// Output parameter: pass a pointer
float groundZ;
if (MISC::GET_GROUND_Z_FOR_3D_COORD(pos.x, pos.y, 1000.0f, &groundZ, FALSE, FALSE))
    pos.z = groundZ;

// Any native by hash
Ped same = invoke<Ped>(0xD80958FC74E988A6);
```

See guide 04.

## Calling natives from Lua

The Lua plugin is from 2015, so it uses the **old names**:

```lua
local player = PLAYER.PLAYER_PED_ID()
local pos = ENTITY.GET_ENTITY_COORDS(player, true)
local w, h = GRAPHICS.GET_SCREEN_RESOLUTION(0, 0)   -- output parameters come back as extra return values
```

Every native it has, with today's name next to it: `../reference/Lua-Natives.md`. Details in [guide 06](/scripting/lua.md).

## Old names and new names

Natives were named gradually by the community. Old mods, old tutorials and the Lua plugin use the old names. The reference lists them under each native ("old names"), and you can search for either.

| Old namespace (2015, Lua plugin) | Current namespace |
| --- | --- |
| `GAMEPLAY` | `MISC` |
| `UI` | `HUD` |
| `CONTROLS` | `PAD` |
| `AI` | `TASK` |
| `TIME` | `CLOCK` |
| `WORLDPROBE` | `SHAPETEST` |
| `NETWORKCASH` | `MONEY` |
| `SYSTEM` | `BUILTIN` |
| `CAM` | `CAMERA` |
| `PATHFIND` | `PATH` |
| `APP` | `APPS` |
| `ITEMSET` | `ITEMSETS` |
| `UNK`, `UNK1` to `UNK3`, `UNK_SC`, `DLC1`, `DLC2` | Split across several namespaces (`MISC`, `SOCIALCLUB`, `DLC`, ...). Check the "Current name" column in Lua-Natives.md |

Names that started with `_` were unofficial guesses. Names like `_0x570389D1C3DE3C6B` had no name at all: the number is the hash.

## Safety

- **Single player only.** `NETWORK_*` and `MONEY` natives touch online services. Never use them, and never take a modded game online.
- **Don't call natives off the script thread.** In C# that means inside `Tick` (or code it calls). In C++, inside your script loop. Calling from elsewhere crashes the game.
- **Unknown parameters (`p0`, `p1`, ...):** start with `false` / `0`, and test.
- **Natives added after build 3725** (the `build` line in the reference) don't exist in build 3725.
