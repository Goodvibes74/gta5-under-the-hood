# Read-only: maps every key in GTA V mission-creator (UGC) JSON files. For each key path (arrays collapsed to "[]"),
# counts how many files contain it, and writes <Out>\ugc-keys.tsv (path, files). Extract the files first, e.g.
#   tools\rpf-cw.ps1 -Archive update\update2.rpf -Pattern "common\data\ugc\*" -ExtractTo <scratch>\ugc
# Usage: powershell -NoProfile -ExecutionPolicy Bypass -File tools\ugc-keys.ps1 -Dir <scratch>\ugc -Out <scratch>
# Takes about five minutes for the 1,001 local files (24 MB). Guide: file-formats/ugc-json.md
param([Parameter(Mandatory = $true)][string]$Dir, [Parameter(Mandatory = $true)][string]$Out)
$ErrorActionPreference = "Stop"
Add-Type -AssemblyName System.Web.Extensions
$ser = New-Object System.Web.Script.Serialization.JavaScriptSerializer
$ser.MaxJsonLength = [int]::MaxValue; $ser.RecursionLimit = 200
$count = @{}; $bad = 0
function Walk($o, [string]$p, $seen) {
  if ($o -is [System.Collections.IDictionary]) {
    foreach ($k in $o.Keys) { $q = if ($p) { "$p.$k" } else { $k }; $seen[$q] = 1; Walk $o[$k] $q $seen } }
  elseif ($o -is [System.Collections.IList] -and -not ($o -is [string])) {
    $q = "$p[]"
    foreach ($e in $o) { if ($e -is [System.Collections.IDictionary] -or ($e -is [System.Collections.IList] -and -not ($e -is [string]))) { Walk $e $q $seen } } }
}
foreach ($f in Get-ChildItem $Dir -Filter *.ugc) {
  try { $j = $ser.DeserializeObject([IO.File]::ReadAllText($f.FullName)) } catch { $bad++; continue }
  $seen = @{}; Walk $j '' $seen
  foreach ($k in $seen.Keys) { $count[$k] = 1 + [int]$count[$k] }
}
New-Item -ItemType Directory -Force $Out | Out-Null
$count.GetEnumerator() | Sort-Object Name | ForEach-Object { "{0}`t{1}" -f $_.Name, $_.Value } |
  Set-Content -Encoding UTF8 (Join-Path $Out "ugc-keys.tsv")
"{0} key paths from {1} files ({2} unreadable) -> {3}" -f $count.Count, (Get-ChildItem $Dir -Filter *.ugc).Count, $bad, $Out
