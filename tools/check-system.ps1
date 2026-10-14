<#
.SYNOPSIS
    Checks that this PC has everything outside the game folder that GTA V Legacy, its mods, and mod
    development need. Read-only: it installs and changes nothing.

.DESCRIPTION
    Every requirement comes from the import tables of the game and mod files (see
    docs/00-getting-started/system-requirements.md). Prints OK or MISSING for each, and what to install.

.EXAMPLE
    powershell -ExecutionPolicy Bypass -File tools\check-system.ps1
    powershell -ExecutionPolicy Bypass -File tools\check-system.ps1 -Dev    # also check the modding tools
#>
param([switch]$Dev)

$sys = Join-Path $env:WINDIR 'System32'
$results = New-Object System.Collections.Generic.List[object]

function Check([string]$group, [string]$name, [bool]$ok, [string]$detail, [string]$fix) {
    $results.Add([pscustomobject]@{ Group = $group; Requirement = $name; Status = $(if ($ok) { 'OK' } else { 'MISSING' }); Detail = $detail; Fix = $(if ($ok) { '' } else { $fix }) })
}

function FilesIn([string[]]$names) {
    $missing = @($names | Where-Object { -not (Test-Path (Join-Path $sys $_)) })
    return , $missing
}

# ---- Play the game
$os = Get-CimInstance Win32_OperatingSystem
$build = [int]$os.BuildNumber
Check 'Play' 'Windows 10 or 11, 64-bit' ($os.OSArchitecture -match '64' -and $build -ge 10240) "$($os.Caption) build $build, $($os.OSArchitecture)" 'GTA V Legacy needs 64-bit Windows 10 or 11'

$mf = FilesIn @('mf.dll', 'mfplat.dll', 'mfreadwrite.dll', 'msdmo.dll')
Check 'Play' 'Media Foundation (video playback)' ($mf.Count -eq 0) $(if ($mf.Count) { "missing: $($mf -join ', ')" } else { 'mf.dll, mfplat.dll, mfreadwrite.dll present' }) 'Windows "N" editions: Settings > Apps > Optional features > add "Media Feature Pack", then restart'

$dx = FilesIn @('d3dcompiler_43.dll', 'd3dx9_43.dll', 'xinput1_3.dll', 'd3dx11_43.dll', 'X3DAudio1_7.dll', 'XAPOFX1_5.dll')
Check 'Play' 'DirectX End-User Runtime (June 2010)' ($dx.Count -eq 0) $(if ($dx.Count) { "missing: $($dx -join ', ')" } else { 'd3dcompiler_43, d3dx9_43, xinput1_3 and related files present' }) 'Run the "DirectX End-User Runtime Web Installer" from microsoft.com'

$vc14 = FilesIn @('vcruntime140.dll', 'vcruntime140_1.dll', 'msvcp140.dll')
$vc14Version = if (Test-Path "$sys\vcruntime140.dll") { (Get-Item "$sys\vcruntime140.dll").VersionInfo.FileVersion } else { '' }
Check 'Play' 'Visual C++ 2015-2022 (v14) runtime, x64' ($vc14.Count -eq 0) $(if ($vc14.Count) { "missing: $($vc14 -join ', ')" } else { "vcruntime140 $vc14Version" }) 'Install "Visual C++ Redistributable" x64 (latest supported, v14) from learn.microsoft.com/cpp/windows/latest-supported-vc-redist'

# ---- Run the mods
$vc12 = FilesIn @('msvcr120.dll', 'msvcp120.dll')
Check 'Mods' 'Visual C++ 2013 (v12) runtime, x64 (for LUA.asi)' ($vc12.Count -eq 0) $(if ($vc12.Count) { "missing: $($vc12 -join ', ')" } else { "msvcr120 $((Get-Item "$sys\msvcr120.dll").VersionInfo.FileVersion)" }) 'Install "Visual C++ Redistributable for Visual Studio 2013" x64 (listed on learn.microsoft.com/cpp/windows/latest-supported-vc-redist)'

$ndp = Get-ItemProperty 'HKLM:\SOFTWARE\Microsoft\NET Framework Setup\NDP\v4\Full' -ErrorAction SilentlyContinue
$release = if ($ndp) { [int]$ndp.Release } else { 0 }
Check 'Mods' '.NET Framework 4.8 or newer (for SHVDN and every .NET mod)' ($release -ge 528040) $(if ($ndp) { "version $($ndp.Version), release $release" } else { 'not found' }) 'Install .NET Framework 4.8 (or 4.8.1) from dotnet.microsoft.com/download/dotnet-framework'

$d47 = FilesIn @('d3dcompiler_47.dll')
Check 'Mods' 'D3DCompiler 47 (for Menyoo)' ($d47.Count -eq 0) 'part of Windows 10 and 11' 'Install Windows updates'

# ---- Mod development
if ($Dev) {
    $sdks = @()
    if (Get-Command dotnet -ErrorAction SilentlyContinue) { $sdks = @(& dotnet --list-sdks 2>$null) }
    Check 'Dev' '.NET SDK (builds C# mods and the doc generator)' ($sdks.Count -gt 0) $(if ($sdks.Count) { ($sdks | ForEach-Object { ($_ -split ' ')[0] }) -join ', ' } else { 'dotnet not found' }) 'Install the .NET SDK from dotnet.microsoft.com/download'

    $tp = "${env:ProgramFiles(x86)}\Reference Assemblies\Microsoft\Framework\.NETFramework\v4.8"
    Check 'Dev' '.NET Framework 4.8 targeting pack' (Test-Path "$tp\mscorlib.dll") $tp 'Visual Studio Installer > Modify > Individual components > ".NET Framework 4.8 targeting pack"'

    $vswhere = "${env:ProgramFiles(x86)}\Microsoft Visual Studio\Installer\vswhere.exe"
    $cpp = @(); $net = @()
    if (Test-Path $vswhere) {
        $cpp = @(& $vswhere -all -products * -requires Microsoft.VisualStudio.Component.VC.Tools.x86.x64 -property displayName)
        $net = @(& $vswhere -all -products * -requires Microsoft.VisualStudio.Workload.ManagedDesktop -property displayName)
    }
    Check 'Dev' 'Visual Studio with .NET desktop development (edit C# mods)' ($net.Count -gt 0) ($net -join ', ') 'Visual Studio Installer > Modify > tick ".NET desktop development"'
    Check 'Dev' 'MSVC C++ build tools x64 (build .asi mods)' ($cpp.Count -gt 0) ($cpp -join ', ') 'Visual Studio Installer > Modify > tick "Desktop development with C++" (or install Build Tools with the C++ workload)'

    $winsdk = Get-ChildItem "${env:ProgramFiles(x86)}\Windows Kits\10\Include" -Directory -ErrorAction SilentlyContinue | Select-Object -ExpandProperty Name
    Check 'Dev' 'Windows 10/11 SDK (C++ headers like windows.h)' ([bool]$winsdk) ($winsdk -join ', ') 'Installed with the C++ workload. Or add "Windows 11 SDK" under Individual components'
}

$results | Format-Table -AutoSize -Wrap Group, Requirement, Status, Detail
$missing = @($results | Where-Object Status -eq 'MISSING')
if ($missing.Count -eq 0) {
    Write-Host 'Everything needed is installed.'
} else {
    Write-Host "$($missing.Count) missing. To fix:"
    foreach ($m in $missing) { Write-Host " - $($m.Requirement): $($m.Fix)" }
}
