# Read-only update check for a GTA V install. Takes a snapshot (GTA5.exe version, sizes and dates of the main
# archives, the list of DLC packs) and writes it to <Out>\snapshot.json. With -Baseline (an older snapshot.json) it
# reports what changed. With -Deps (a text file, one asset name per line, "#" for comments) and CodeWalker
# (-CodeWalker or $env:CODEWALKER_DIR) it lists every file name inside the game's archives and reports which
# dependency names no longer exist. Never writes to the game folder. Guide: docs/core/surviving-updates.md (R11.2).
# Usage:
#   powershell -NoProfile -ExecutionPolicy Bypass -File tools\update-check.ps1 -Game <game folder> -Out <scratch> [-Baseline <old snapshot.json>] [-Deps <deps.txt>]
# The snapshot takes a second; the dependency check walks every archive (about 15 s for 486,000 file names).
param(
    [string]$Game = (Get-Location).Path,
    [Parameter(Mandatory = $true)][string]$Out,
    [string]$Baseline,
    [string]$Deps,
    [string]$CodeWalker = $env:CODEWALKER_DIR
)
$ErrorActionPreference = "Stop"
New-Item -ItemType Directory -Force $Out | Out-Null

# 1. Snapshot
$exe = Join-Path $Game "GTA5.exe"
if (-not (Test-Path $exe)) { throw "GTA5.exe not found in $Game" }
$ver = (Get-Item $exe).VersionInfo
$archives = @("common.rpf", "update\update.rpf", "update\update2.rpf") + (Get-ChildItem $Game -Filter "x64*.rpf" | ForEach-Object Name)
$snap = [ordered]@{
    Taken    = (Get-Date).ToString("yyyy-MM-dd HH:mm")
    Version  = $ver.FileVersion
    Product  = $ver.ProductVersion
    Archives = [ordered]@{}
    DlcPacks = @()
}
foreach ($a in $archives) {
    $p = Join-Path $Game $a
    if (Test-Path $p) { $f = Get-Item $p; $snap.Archives[$a] = [ordered]@{ Size = $f.Length; Written = $f.LastWriteTime.ToString("yyyy-MM-dd HH:mm") } }
}
$dlcDir = Join-Path $Game "update\x64\dlcpacks"
if (Test-Path $dlcDir) { $snap.DlcPacks = @(Get-ChildItem $dlcDir -Directory | ForEach-Object Name | Sort-Object) }
$snap | ConvertTo-Json -Depth 5 | Out-File -Encoding utf8 (Join-Path $Out "snapshot.json")
"Game version {0}; {1} archives; {2} DLC packs. Snapshot written to {3}" -f $snap.Version, $snap.Archives.Count, $snap.DlcPacks.Count, (Join-Path $Out "snapshot.json")

# 2. Compare with an older snapshot
if ($Baseline) {
    $old = Get-Content $Baseline -Raw | ConvertFrom-Json
    $report = New-Object System.Collections.Generic.List[string]
    if ($old.Version -ne $snap.Version) { $report.Add("VERSION  $($old.Version) -> $($snap.Version)") } else { $report.Add("VERSION  unchanged ($($snap.Version))") }
    foreach ($a in $snap.Archives.Keys) {
        $o = $old.Archives.$a
        $n = $snap.Archives[$a]
        if (-not $o) { $report.Add("ARCHIVE  new: $a") }
        elseif ($o.Size -ne $n.Size -or $o.Written -ne $n.Written) { $report.Add("ARCHIVE  changed: $a ($($o.Size) -> $($n.Size) bytes)") }
    }
    foreach ($p in $snap.DlcPacks) { if ($old.DlcPacks -notcontains $p) { $report.Add("DLC      new pack: $p") } }
    foreach ($p in $old.DlcPacks) { if ($snap.DlcPacks -notcontains $p) { $report.Add("DLC      removed pack: $p") } }
    $report | Out-File -Encoding utf8 (Join-Path $Out "changes.txt")
    $report
}

# 3. Check a mod's asset names against every file name in the archives
if ($Deps) {
    if (-not $CodeWalker) { throw "The dependency check needs -CodeWalker (or CODEWALKER_DIR): the folder that contains CodeWalker.Core.dll." }
    [void][Reflection.Assembly]::LoadFrom((Join-Path $CodeWalker "CodeWalker.Core.dll"))
    [CodeWalker.GameFiles.GTA5Keys]::LoadFromPath($Game, $null)
    $names = New-Object 'System.Collections.Generic.HashSet[string]'
    $rpfs = @($archives | ForEach-Object { Join-Path $Game $_ } | Where-Object { Test-Path $_ })
    if (Test-Path $dlcDir) { $rpfs += @(Get-ChildItem $dlcDir -Recurse -Filter *.rpf | ForEach-Object FullName) }
    foreach ($path in $rpfs) {
        try {
            $rel = $path.Substring($Game.Length).TrimStart('\')
            $rpf = New-Object CodeWalker.GameFiles.RpfFile($path, $rel)
            $rpf.ScanStructure($null, $null)
            $stack = New-Object System.Collections.Stack
            $stack.Push($rpf)
            while ($stack.Count -gt 0) {
                $r = $stack.Pop()
                if ($r.Children) { foreach ($c in $r.Children) { $stack.Push($c) } }
                foreach ($e in $r.AllEntries) {
                    if ($e -is [CodeWalker.GameFiles.RpfFileEntry]) {
                        $n = $e.Name.ToLowerInvariant()
                        [void]$names.Add($n)
                        $dot = $n.LastIndexOf('.')
                        if ($dot -gt 0) { [void]$names.Add($n.Substring(0, $dot)) }
                    }
                }
            }
        } catch { Write-Warning "Skipped $path : $($_.Exception.Message)" }
    }
    $missing = New-Object System.Collections.Generic.List[string]
    $checked = 0
    foreach ($line in Get-Content $Deps) {
        $d = $line.Trim()
        if (-not $d -or $d.StartsWith("#")) { continue }
        $checked++
        if (-not $names.Contains($d.ToLowerInvariant())) { $missing.Add($d) }
    }
    $missing | Out-File -Encoding utf8 (Join-Path $Out "missing.txt")
    "Checked {0} names against {1} archive file names; {2} missing (see missing.txt)." -f $checked, $names.Count, $missing.Count
}
