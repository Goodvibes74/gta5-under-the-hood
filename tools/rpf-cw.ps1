# Read-only list/extract for any archive, including Rockstar's encrypted ones, through the CodeWalker.Core library in
# your CodeWalker folder (-CodeWalker or $env:CODEWALKER_DIR). Lists every file (nested archives included) whose inner path matches -Pattern, and
# copies matching non-resource files to -ExtractTo. Never writes archives.
# Usage: powershell -NoProfile -ExecutionPolicy Bypass -File tools\rpf-cw.ps1 -Archive update\update.rpf -Pattern "common\data\mpstats*" [-ExtractTo <scratch folder>]
param([string]$Game = (Get-Location).Path, [string]$CodeWalker = $env:CODEWALKER_DIR, [Parameter(Mandatory = $true)][string]$Archive, [string]$Pattern = "*", [string]$ExtractTo)
$ErrorActionPreference = "Stop"
if (-not $CodeWalker) { throw "Set -CodeWalker (or the CODEWALKER_DIR environment variable) to the folder that contains CodeWalker.Core.dll." }
[void][Reflection.Assembly]::LoadFrom((Join-Path $CodeWalker "CodeWalker.Core.dll"))
[CodeWalker.GameFiles.GTA5Keys]::LoadFromPath($Game, $null)
$rpf = New-Object CodeWalker.GameFiles.RpfFile((Join-Path $Game $Archive), $Archive)
$rpf.ScanStructure($null, $null)
$stack = New-Object System.Collections.Stack; $stack.Push($rpf)
while ($stack.Count -gt 0) {
    $f = $stack.Pop()
    if ($f.Children) { foreach ($c in $f.Children) { $stack.Push($c) } }
    foreach ($e in $f.AllEntries) {
        if (-not ($e -is [CodeWalker.GameFiles.RpfFileEntry])) { continue }
        $inner = $e.Path.Substring($Archive.Length).TrimStart('\')
        if ($inner -notlike $Pattern) { continue }
        Write-Output ("{0,10} {1}" -f $e.FileSize, $inner)
        if ($ExtractTo -and -not ($e -is [CodeWalker.GameFiles.RpfResourceFileEntry])) {
            $b = $f.ExtractFile($e)
            $dest = Join-Path $ExtractTo ($inner -replace '[\\/:]', '_')
            New-Item -ItemType Directory -Force $ExtractTo | Out-Null
            [IO.File]::WriteAllBytes($dest, $b)
        }
    }
}
