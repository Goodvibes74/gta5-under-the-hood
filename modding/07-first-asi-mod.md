# 7. Your first C++ (.asi) mod

A native plugin that shows a notification when the game has loaded and, on a key, draws your position on screen every frame. Built with Visual Studio and the ScriptHookV SDK. Part of the [modding path](README.md). Background: [natives](/scripting/natives.md#calling-natives-from-c), [languages](/scripting/languages.md).

Choose C++ when you need speed, DirectX drawing, or the game's memory. For everything else C# is easier and safer: a C++ bug crashes the whole game, with no console to tell you why.

## Short version

- An `.asi` is a 64-bit Windows DLL with a different extension. The ASI loader loads it; it then talks to `ScriptHookV.dll` directly.
- `DllMain` only **registers** your main function (`scriptRegister`). No natives in `DllMain`.
- Your main function is an endless loop that calls `scriptWait(0)` every iteration.
- Keyboard input arrives on another thread: only record it there, act on it in the loop.
- Build Release x64, close the game, copy the `.asi` next to `GTA5.exe`.

## 1. Get the tools

- Visual Studio Community with **Desktop development with C++** (https://visualstudio.microsoft.com/downloads/).
- The **ScriptHookV SDK** from http://www.dev-c.com/gtav/scripthookv/. Unzip it somewhere outside the game folder. It holds (**Known**):

  | Folder | What |
  | --- | --- |
  | `inc\` | `main.h` (ScriptHookV's functions), `types.h` (`Ped`, `Vehicle`, `Hash`, `Vector3`), `nativeCaller.h` (calls a native by hash), `natives.h` (every native as a function), `enums.h` |
  | `lib\ScriptHookV.lib` | What you link against |
  | `samples\` | Sample plugins, including the source of `NativeTrainer` |

- **Native names.** The SDK's `natives.h` uses older names for some namespaces (for example `UI::` for today's `HUD::`, `GAMEPLAY::` for `MISC::`). NativeDB can generate a C++ header with the current names (its "Generate code" option; **Known**), which matches the code on this page and the names used across this repo. Either works: the game only sees hashes. If you keep the SDK's header, rename the calls below using the [old-name table](/scripting/natives.md#old-names-and-new-names).

## 2. Create the project

1. Visual Studio: **Create a new project**, "Dynamic-Link Library (DLL)" for C++. Name it `FirstAsi`, outside the game folder.
2. Delete the generated `dllmain.cpp`, `framework.h`, `pch.h` and `pch.cpp`; in Project Properties, C/C++, Precompiled Headers, set "Not Using Precompiled Headers".
3. Set these project properties for **Release | x64** (and Debug | x64 if you want breakpoints later):

   | Property | Value | Why |
   | --- | --- | --- |
   | Platform | x64 | GTA V is 64-bit |
   | Advanced, Target File Extension | `.asi` | The ASI loader only loads `.asi` files |
   | C/C++, General, Additional Include Directories | `<SDK>\inc` | The SDK headers |
   | Linker, Input, Additional Dependencies | add `<SDK>\lib\ScriptHookV.lib` | ScriptHookV's functions |
   | C/C++, Code Generation, Runtime Library | Multi-threaded (`/MT`) | Players don't need an extra Visual C++ runtime for your mod |
   | C/C++, Language, C++ Language Standard | C++17 or C++20 | Generated native headers use modern C++ |
   | C/C++, Command Line, Additional Options | `/bigobj` | The natives header is huge |
   | C/C++, Preprocessor Definitions | add `NOMINMAX;WIN32_LEAN_AND_MEAN` | Stops `windows.h` macros clashing with native names |

## 3. The code

Three files. `script.h`:

```cpp
#pragma once
#include <windows.h>
#include "main.h"      // ScriptHookV: scriptRegister, scriptWait, keyboardHandlerRegister ...
#include "natives.h"   // or the header you generated from NativeDB

void ScriptMain();
void OnKeyboardMessage(DWORD key, WORD repeats, BYTE scanCode, BOOL isExtended,
                       BOOL isWithAlt, BOOL wasDownBefore, BOOL isUpNow);
```

`main.cpp`, the entry point Windows calls when the ASI loader loads your file:

```cpp
#include "script.h"

BOOL APIENTRY DllMain(HMODULE module, DWORD reason, LPVOID)
{
    switch (reason)
    {
    case DLL_PROCESS_ATTACH:
        scriptRegister(module, ScriptMain);           // only register here: no natives in DllMain
        keyboardHandlerRegister(OnKeyboardMessage);
        break;
    case DLL_PROCESS_DETACH:
        scriptUnregister(module);
        keyboardHandlerUnregister(OnKeyboardMessage);
        break;
    }
    return TRUE;
}
```

`script.cpp`, your mod:

```cpp
#include "script.h"
#include <cstdio>

static const DWORD ToggleKey = VK_PAUSE;   // pick a key no other mod uses
static volatile bool togglePressed = false;
static bool showPosition = false;

void OnKeyboardMessage(DWORD key, WORD, BYTE, BOOL, BOOL, BOOL wasDownBefore, BOOL isUpNow)
{
    // Runs on the window thread, not the script thread: only record the press here.
    if (key == ToggleKey && !isUpNow && !wasDownBefore)
        togglePressed = true;
}

static void Notify(const char* text)
{
    HUD::BEGIN_TEXT_COMMAND_THEFEED_POST("STRING");
    HUD::ADD_TEXT_COMPONENT_SUBSTRING_PLAYER_NAME(text);
    HUD::END_TEXT_COMMAND_THEFEED_POST_TICKER(FALSE, TRUE);
}

static void DrawText(const char* text, float x, float y)
{
    HUD::SET_TEXT_FONT(0);
    HUD::SET_TEXT_SCALE(0.0f, 0.4f);
    HUD::SET_TEXT_COLOUR(255, 255, 255, 255);
    HUD::SET_TEXT_OUTLINE();
    HUD::BEGIN_TEXT_COMMAND_DISPLAY_TEXT("STRING");
    HUD::ADD_TEXT_COMPONENT_SUBSTRING_PLAYER_NAME(text);
    HUD::END_TEXT_COMMAND_DISPLAY_TEXT(x, y, 0);
}

void ScriptMain()
{
    while (DLC::GET_IS_LOADING_SCREEN_ACTIVE())   // wait for the loading screen to finish
        scriptWait(0);

    Notify("FirstAsi loaded");

    while (true)
    {
        if (togglePressed)
        {
            togglePressed = false;
            showPosition = !showPosition;
        }

        if (showPosition)
        {
            Vector3 pos = ENTITY::GET_ENTITY_COORDS(PLAYER::PLAYER_PED_ID(), TRUE);
            char buffer[96];
            std::snprintf(buffer, sizeof(buffer), "X %.1f  Y %.1f  Z %.1f", pos.x, pos.y, pos.z);
            DrawText(buffer, 0.01f, 0.01f);       // drawn again every frame, or it vanishes
        }

        scriptWait(0);                            // give the frame back. Every iteration, always
    }
}
```

This is the same pattern the official `NativeTrainer` sample uses, written smaller. (**Verified**: a plugin with this structure and these natives builds and links against ScriptHookV 3889.0 for build 3725.)

## 4. Build, install, test

1. Build **Release | x64**. The output is `x64\Release\FirstAsi.asi`.
2. **Close the game,** copy `FirstAsi.asi` next to `GTA5.exe`, add it to your file list.
3. Start story mode. You should see "FirstAsi loaded"; press your key and your coordinates appear top left.
4. Check `asiloader.log` (your `.asi` loaded) and `ScriptHookV.log` (a script was registered for it).

To uninstall, delete the `.asi`.

## 5. The rules that keep C++ mods from crashing

| Rule | Why |
| --- | --- |
| Natives only inside `ScriptMain` (or functions it calls) | Natives must run on a script thread. `DllMain`, the keyboard handler and your own `std::thread` are not script threads |
| `scriptWait` in every loop iteration, including inner waiting loops | Without it the game never gets the frame back and freezes |
| Load a model before using it: `STREAMING::REQUEST_MODEL(hash)`, wait in a loop with `scriptWait(0)` until `STREAMING::HAS_MODEL_LOADED(hash)`, create, then `STREAMING::SET_MODEL_AS_NO_LONGER_NEEDED(hash)` | Creating with an unloaded model fails or crashes |
| Prefer natives to memory addresses | Memory offsets and global indices change with every game update; natives survive ([surviving updates](/docs/core/surviving-updates.md)) |
| Check pointers and handles before use (`ENTITY::DOES_ENTITY_EXIST`) | A deleted entity's handle is not safe to use |

## 6. Debugging

- A crash closes the game. Check Windows Event Viewer (Windows Logs, Application) for the faulting module: if it names your `.asi`, it's yours.
- Breakpoints: build **Debug | x64**, copy the `.asi` **and** its `.pdb` next to `GTA5.exe`, start the game, then in Visual Studio use Debug, Attach to Process, `GTA5.exe`, code type **Native**.
- Your own log: `std::ofstream("FirstAsi.log", std::ios::app) << "message\n";` (needs `<fstream>`; relative paths are the game folder). Log events, not every frame.

## Exercises

1. Show your current vehicle's speed instead of your position.
2. Add a second key that spawns a car in front of you, with the model-loading pattern from the rules table.
3. Read the SDK's `NativeTrainer` sample and find where it handles its menu keys. Compare it with how you handle `ToggleKey`.
4. Find `getGlobalPtr` in `main.h`. Read [global map](/docs/core/global-map.md) and explain why a mod that relies on a global index will break on the next update.

Next: [8. Debugging](08-debugging.md).
