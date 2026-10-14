# Read-only: builds the script launch graph (who starts whom, with stack sizes) from the decompiled scripts
# clone at a pinned commit, using git grep (nothing is exported or copied). Finds direct START_NEW_SCRIPT* calls
# and wrapper calls of the form func_N("name" | joaat("name") | hash, stack), and resolves name hashes with joaat.
# Launches whose script name comes from a variable or a lookup table are not resolved (see the guide).
# Writes <Out>\launches.tsv (caller, callee, stack, stack name, via, line) and <Out>\launch-graph.md.
# Usage: powershell -NoProfile -ExecutionPolicy Bypass -File tools\script-launch-graph.ps1 -Out <scratch folder>
# Takes under a minute. Guide: docs/core/runtime-scripts.md
param([string]$Repo = "..\GTA-V-Decompiled-Scripts", [string]$Commit = "6c18d3e8b",
      [Parameter(Mandatory = $true)][string]$Out)
$ErrorActionPreference = "Stop"
New-Item -ItemType Directory -Force $Out | Out-Null

Add-Type -Language CSharp -TypeDefinition @"
public static class Joaat { public static int Hash(string s) { uint h = 0;
  foreach (char c in s.ToLowerInvariant()) { h += (byte)c; h += h << 10; h ^= h >> 6; }
  h += h << 3; h ^= h >> 11; h += h << 15; return unchecked((int)h); } }
"@

# Stack pools from vanilla common\data\gameconfig.xml (build 3725): size -> name.
$stackNames = @{ 128 = "MICRO"; 512 = "MINI"; 1424 = "DEFAULT"; 1828 = "SPECIAL_ABILITY"; 2050 = "FRIEND";
  2324 = "SHOP/IE_DELIVERY"; 2512 = "SMPL_INTERIOR"; 2600 = "CELLPHONE"; 3076 = "PAUSE_MENU_SCRIPT"; 3568 = "VEHICLE_SPAWN";
  3750 = "CAR_MOD_SHOP"; 3800 = "SHOP_CONTROLLER"; 4000 = "CONTACTS_APP"; 4080 = "DEBUG_SCRIPT"; 4088 = "SOAK_TEST";
  4096 = "NETWORK_BOT"; 4592 = "APP_INTERNET"; 4600 = "INGAMEHUD"; 5000 = "AM_MP_YACHT"; 5050 = "MULTIPLAYER_MISSION";
  8032 = "TRANSITION"; 8344 = "SCRIPT_XML"; 9800 = "INTERACTION_MENU"; 14100 = "WAREHOUSE"; 15900 = "ACTIVITY_CREATOR_INT";
  19400 = "PROPERTY_INT"; 28000 = "FMMC_LAUNCHER"; 35000 = "DEBUG_MENU"; 35250 = "MP_LAUNCH_SCRIPT"; 64500 = "MISSION";
  89500 = "MULTIPLAYER_FREEMODE" }

$names = @{}; $byHash = @{}
foreach ($n in (git -C $Repo show "${Commit}:all_script_names.txt")) {
  $n = $n.Trim(); if ($n) { $names[$n] = 1; $byHash[[Joaat]::Hash($n)] = $n } }

# No literal quotes here: Windows PowerShell mangles them when passing arguments to git. "." stands for the
# quote, and the exact match is done by $rx below.
$pattern = '(START_NEW_SCRIPT[A-Z_]*|func_[0-9]+)\((joaat\()?(.[A-Za-z0-9_]+.|-?[0-9]{5,11})\)?, (&[^,]*, [0-9]+, )?-?[0-9]{3,5}\)'
$raw = git -C $Repo grep -n -o -i -E $pattern $Commit -- decompiled_scripts
$rx = [regex]'^[^:]+:decompiled_scripts/([^:]+)\.c:(\d+):([A-Za-z_0-9]+)\((?:joaat\()?(?:"([A-Za-z0-9_]+)"|(-?\d+))\)?, (?:&[^,]*, \d+, )?(-?\d+)\)$'
$rows = New-Object System.Collections.Generic.List[string]
foreach ($line in $raw) {
  $m = $rx.Match($line); if (-not $m.Success) { continue }
  $callee = if ($m.Groups[4].Success) { $m.Groups[4].Value.ToLowerInvariant() } else { $byHash[[int]$m.Groups[5].Value] }
  if (-not $callee -or -not $names.ContainsKey($callee)) { continue }
  $stack = [int]$m.Groups[6].Value
  $sn = if ($stackNames.ContainsKey($stack)) { $stackNames[$stack] } else { "?" }
  $via = if ($m.Groups[3].Value -like "START_NEW_SCRIPT*") { $m.Groups[3].Value } else { "wrapper" }
  $rows.Add("$($m.Groups[1].Value)`t$callee`t$stack`t$sn`t$via`t$($m.Groups[2].Value)") }
$uniq = $rows | Sort-Object -Unique
$uniq | Set-Content -Encoding UTF8 (Join-Path $Out "launches.tsv")

# Markdown: one line per caller, unique callees with their stacks.
$md = New-Object System.Text.StringBuilder
[void]$md.AppendLine("| Caller | Starts (stack) |"); [void]$md.AppendLine("| --- | --- |")
$uniq | ForEach-Object { $f = $_ -split "`t"; [pscustomobject]@{ Caller = $f[0]; Callee = "$($f[1]) ($($f[2]))" } } |
  Group-Object Caller | Sort-Object Name | ForEach-Object {
    $c = ($_.Group.Callee | Sort-Object -Unique | ForEach-Object { "``$_``" }) -join ", "
    [void]$md.AppendLine("| ``$($_.Name)`` | $c |") }
$md.ToString() | Set-Content -Encoding UTF8 (Join-Path $Out "launch-graph.md")
"{0} launch lines, {1} unique edges from {2} callers -> {3}" -f $raw.Count, $uniq.Count,
  (($uniq | ForEach-Object { ($_ -split "`t")[0] }) | Sort-Object -Unique).Count, $Out
