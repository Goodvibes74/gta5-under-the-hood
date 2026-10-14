# System requirements outside the game folder

What Windows itself must have installed before you can play GTA V Legacy with mods, or build new ones. None of it lives in the game folder, so a fresh PC (or a reinstalled Windows) needs it set up again.

**Check any PC in one command:**

```powershell
powershell -ExecutionPolicy Bypass -File tools\check-system.ps1        # play + mods
powershell -ExecutionPolicy Bypass -File tools\check-system.ps1 -Dev   # also the modding tools
```

It only reads: it prints OK or MISSING for each item below, and what to install.

Where to download each item: [the [setup page](setup.md)](setup.md). On Linux, these go into the game's Wine/Proton prefix instead: see [`LINUX.md`](LINUX.md).

> **Sources:** the import table of every `.exe`, `.asi` and `.dll` in the game folder and `scripts/` (`dumpbin /dependents`, Visual Studio Build Tools), minus the DLLs the game folder ships itself. Installed versions from the Windows registry and `System32` on 2026-10-09.

## Status on this PC (2026-10-09)

Windows 11 Pro 64-bit, build 26200. Everything below is installed.

## 1. To play the game

| Requirement | Needed by (from import tables) | Installed here | Where to get it |
| --- | --- | --- | --- |
| **Windows 10 or 11, 64-bit** | Everything: GTA V is a 64-bit game | Windows 11 Pro, build 26200 | |
| **Graphics card and driver with DirectX 11** | `GTA5.exe` (loads Direct3D at runtime, so it isn't in the import table) | Yes | Your GPU maker's driver (NVIDIA, AMD, Intel). Direct3D 11 itself is part of Windows |
| **DirectX End-User Runtime (June 2010)**: `d3dcompiler_43.dll`, `d3dx9_43.dll`, `xinput1_3.dll`, `d3dx11_43.dll`, `X3DAudio1_7.dll`, `XAPOFX1_5.dll` | `GTA5.exe` (`d3dcompiler_43`), `GFSDK_ShadowLib.win64.dll` (`d3dx9_43`), the Social Club library (`xinput1_3`) | Yes, all six | "DirectX End-User Runtime Web Installer" on microsoft.com (some game installers also ship `dxwebsetup.exe`). Windows 10/11 don't include these older files |
| **Visual C++ 2015-2022 runtime (v14), x64**: `vcruntime140.dll`, `vcruntime140_1.dll`, `msvcp140.dll` | The game launchers (`GTAVLauncher.exe`, `GTAVLanguageSelect.exe`) and the game's audio and network libraries (`libcurl`, `libtox`, `opus`, `opusenc`, `fvad`, `zlib1`) | Yes, 14.51 | "Visual C++ Redistributable" x64, latest supported (v14), from learn.microsoft.com/cpp/windows/latest-supported-vc-redist. One install covers 2015 to 2026 |
| **Media Foundation**: `mf.dll`, `mfplat.dll`, `mfreadwrite.dll` | `GTA5.exe` (videos) | Yes | Built into Windows, except the "N" editions: Settings > Apps > Optional features > "Media Feature Pack" |
| Built-in Windows parts: Direct3D 9, DirectSound, OpenGL, WinHTTP, WinINet, cryptography, networking | `GTA5.exe`, NVIDIA libraries, Social Club layer | Yes | Part of every Windows 10/11 install. Keep Windows updated |

## 2. To run the installed mods

| Requirement | Needed by | Installed here | Where to get it |
| --- | --- | --- | --- |
| Everything in section 1 | | Yes | |
| **Visual C++ 2015-2022 runtime (v14), x64** (same as above) | `Menyoo.asi`, `ScriptHookVDotNet.asi`, `WeaponLimitsAdjuster.asi` | Yes | As above |
| **Visual C++ 2013 runtime (v12), x64**: `msvcr120.dll`, `msvcp120.dll` | `LUA.asi` | Yes, 12.0.40664 | "Visual C++ Redistributable for Visual Studio 2013", x64. Listed on the same Microsoft page as above. Without it, the Lua plugin silently doesn't load |
| **.NET Framework 4.8 or 4.8.1** (`mscoree.dll`) | `ScriptHookVDotNet.asi` and every .NET mod and library (LemonUI, NativeUI, iFruitAddon2 ...) | Yes, 4.8.1 (release 533509) | Built into Windows 11 and recent Windows 10. Otherwise dotnet.microsoft.com/download/dotnet-framework |
| **D3DCompiler 47** (`d3dcompiler_47.dll`) | `Menyoo.asi` | Yes | Part of Windows 10/11 |

Nothing else outside the game folder is needed: ScriptHookV, SHVDN, the ASI loader, LemonUI and the rest all ship inside the game folder.

## 3. To develop mods

Check with `tools\check-system.ps1 -Dev`.

| Requirement | Needed for | Installed here | Where to get it |
| --- | --- | --- | --- |
| **.NET SDK** (10.x) | Building C# mods with `dotnet build`, running the doc generator | 10.0.103, 10.0.401 | dotnet.microsoft.com/download |
| **.NET Framework 4.8 targeting pack** | Compiling C# mods against .NET Framework 4.8 (what SHVDN runs) | Yes | Visual Studio Installer > Individual components |
| **Visual Studio 2026 with ".NET desktop development"** | Editing and debugging C# mods in the IDE | Community 2026 | visualstudio.microsoft.com (Community is free) |
| **MSVC C++ build tools x64 (toolset v145) and the Windows SDK** | Building C++ `.asi` mods | Build Tools 2026, Windows SDK 10.0.26100 | Visual Studio Installer, "Desktop development with C++" |
| "Desktop development with C++" in **Visual Studio Community** | Opening C++ projects in the IDE (the command line works without it) | **Not installed** | Visual Studio Installer, "Desktop development with C++" |

## Not needed

| Item | Why not |
| --- | --- |
| `mss64.dll` (Miles Sound System) | `bink2w64.dll` lists it as a *delayed* import, loaded only if used. It isn't in Windows or the game folder, and the game runs, so it's never used |
| 32-bit (x86) Visual C++ runtimes | Every game and mod file is 64-bit |
| XNA, Java, Python, Node.js | Nothing in the game or the common mods uses them |
| .NET 5/6/8/10 *runtime* | SHVDN runs on .NET Framework 4.8, a different runtime. The .NET SDK above is only for building |

## After reinstalling Windows or moving to another PC

1. Copy the game folder.
2. Run `tools\check-system.ps1`.
3. Install what it reports as missing, in this order: DirectX June 2010 (web installer from microsoft.com), Visual C++ v14 x64, Visual C++ 2013 x64, .NET Framework 4.8 (if missing), and the Media Feature Pack (N editions only).
4. Run it again until everything is OK.
5. For modding, run it with `-Dev` and install the tools it lists.
