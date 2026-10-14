# Read-only inventory of the vanilla DLC packs (update\x64\dlcpacks) using the CodeWalker.Core library in
# your CodeWalker folder (-CodeWalker or $env:CODEWALKER_DIR). Decrypts in memory and never writes archives. Writes each pack's setup2.xml,
# content.xml and vehicles.meta plus dlcscan.json to -Out. Report: docs/entities/vehicles/dlc-packs.md.
# Usage: powershell -NoProfile -ExecutionPolicy Bypass -File tools/dlc-scan.ps1 -Out <scratch folder> [-Only "mpheist*"]
# Takes about 5 minutes for all 89 packs.
param(
    [string]$Game = (Get-Location).Path, [string]$CodeWalker = $env:CODEWALKER_DIR,
    [Parameter(Mandatory = $true)][string]$Out,
    [string]$Only = "*"
)
$ErrorActionPreference = "Stop"
if (-not $CodeWalker) { throw "Set -CodeWalker (or the CODEWALKER_DIR environment variable) to the folder that contains CodeWalker.Core.dll." }
$cw = Join-Path $CodeWalker "CodeWalker.Core.dll"
[void][Reflection.Assembly]::LoadFrom($cw)
[CodeWalker.GameFiles.GTA5Keys]::LoadFromPath($Game, $null)
New-Item -ItemType Directory -Force $Out | Out-Null

$results = @()
$packs = Get-ChildItem (Join-Path $Game "update\x64\dlcpacks") -Directory | Where-Object { $_.Name -like $Only }
foreach ($pack in $packs) {
    $row = [ordered]@{ Pack = $pack.Name; Name = ""; Order = ""; Vehicles = @(); Ymaps = 0; Peds = 0; Weapons = 0; Clothing = 0; Scripts = 0; Error = "" }
    foreach ($rpfPath in Get-ChildItem $pack.FullName -Filter *.rpf) {
        try {
            $rel = "update\x64\dlcpacks\$($pack.Name)\$($rpfPath.Name)"
            $rpf = New-Object CodeWalker.GameFiles.RpfFile($rpfPath.FullName, $rel)
            $rpf.ScanStructure($null, $null)
            $all = New-Object System.Collections.Generic.List[CodeWalker.GameFiles.RpfFile]
            $stack = New-Object System.Collections.Stack
            $stack.Push($rpf)
            while ($stack.Count -gt 0) {
                $f = $stack.Pop(); $all.Add($f)
                if ($f.Children) { foreach ($c in $f.Children) { $stack.Push($c) } }
            }
            foreach ($f in $all) {
                foreach ($e in $f.AllEntries) {
                    if (-not ($e -is [CodeWalker.GameFiles.RpfFileEntry])) { continue }
                    $n = $e.NameLower
                    if ($n.EndsWith(".ymap")) { $row.Ymaps++ }
                    elseif ($n.EndsWith(".ysc")) { $row.Scripts++ }
                    elseif ($n -like "*ped*.ymt" -or $n -eq "peds.meta") { $row.Peds++ }
                    elseif ($n -like "weapon*.meta") { $row.Weapons++ }
                    elseif ($n -like "*.ydd" -and $e.Path -match "streamedpeds|mp_[mf]_freemode") { $row.Clothing++ }
                    if ($n -eq "setup2.xml" -or $n -eq "vehicles.meta" -or $n -eq "content.xml") {
                        $bytes = $f.ExtractFile($e)
                        if ($bytes) {
                            $text = [Text.Encoding]::UTF8.GetString($bytes)
                            $dest = Join-Path $Out "$($pack.Name)\$($rpfPath.BaseName)_$($e.Path -replace '[\\/:]','_')"
                            New-Item -ItemType Directory -Force (Split-Path $dest) | Out-Null
                            [IO.File]::WriteAllText($dest, $text)
                            if ($n -eq "setup2.xml") {
                                if ($text -match "<nameHash>([^<]+)</nameHash>") { $row.Name = $Matches[1] }
                                if ($text -match '<order value="(\d+)"') { $row.Order = $Matches[1] }
                            }
                            if ($n -eq "vehicles.meta") {
                                $row.Vehicles += ([regex]::Matches($text, "<modelName>([^<]+)</modelName>") | ForEach-Object { $_.Groups[1].Value })
                            }
                        }
                    }
                }
            }
        } catch { $row.Error += "$($rpfPath.Name): $($_.Exception.Message); " }
    }
    $row.Vehicles = ($row.Vehicles | Sort-Object -Unique)
    $results += [pscustomobject]$row
    Write-Host ("{0,-20} {1,-18} order {2,-4} veh {3,-3} ymap {4,-4} ysc {5,-3} {6}" -f $row.Pack, $row.Name, $row.Order, $row.Vehicles.Count, $row.Ymaps, $row.Scripts, $row.Error)
}
$results | ConvertTo-Json -Depth 4 | Set-Content -Encoding UTF8 (Join-Path $Out "dlcscan.json")
