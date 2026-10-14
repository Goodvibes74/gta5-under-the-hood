# Read-only: decrypts every compiled script (.ysc) in update\update2.rpf with the CodeWalker.Core library in
# your CodeWalker folder (-CodeWalker or $env:CODEWALKER_DIR) and writes each script's header numbers and string table to <Out>\<name>.txt,
# plus <Out>\_summary.tsv (name, code size, statics, globals, natives, strings). Never writes archives.
# Usage: powershell -NoProfile -ExecutionPolicy Bypass -File tools\ysc-dump.ps1 -Out <scratch folder> [-Only "freemode"]
# All 1,143 scripts take about 10 minutes. Guide: docs/00-getting-started/research-tools.md
param([string]$Game = (Get-Location).Path, [string]$CodeWalker = $env:CODEWALKER_DIR, [Parameter(Mandatory = $true)][string]$Out, [string]$Only = "*")
$ErrorActionPreference = "Stop"
if (-not $CodeWalker) { throw "Set -CodeWalker (or the CODEWALKER_DIR environment variable) to the folder that contains CodeWalker.Core.dll." }
[void][Reflection.Assembly]::LoadFrom((Join-Path $CodeWalker "CodeWalker.Core.dll"))
[CodeWalker.GameFiles.GTA5Keys]::LoadFromPath($Game, $null)

Add-Type -Language CSharp -TypeDefinition @"
using System; using System.IO; using System.IO.Compression; using System.Collections.Generic; using System.Text;
public static class Ysc {
    // RSC7 resource: 16-byte header (magic, version, system flags, graphics flags), then raw deflate data.
    public static byte[] Inflate(byte[] rsc) {
        if (rsc.Length < 16 || BitConverter.ToUInt32(rsc, 0) != 0x37435352) return rsc;
        using (var ms = new MemoryStream(rsc, 16, rsc.Length - 16))
        using (var ds = new DeflateStream(ms, CompressionMode.Decompress))
        using (var o = new MemoryStream()) { ds.CopyTo(o); return o.ToArray(); }
    }
    static long Off(ulong p) { return (long)(p & 0x0FFFFFFF); }
    public static string Dump(byte[] d, out string summary) {
        var sb = new StringBuilder();
        // Header (x64): 0x00 vtable, 0x08 page map, 0x10 code pages, 0x18 globals signature, 0x1C code size,
        // 0x20 params, 0x24 statics, 0x28 globals, 0x2C natives, 0x30/0x38/0x40 offsets, 0x58 name hash,
        // 0x60 name, 0x68 string pages, 0x70 strings size. Pointers are 0x50000000-based.
        uint codeLen = BitConverter.ToUInt32(d, 0x1C);
        uint statics = BitConverter.ToUInt32(d, 0x24);
        uint globals = BitConverter.ToUInt32(d, 0x28);
        uint natives = BitConverter.ToUInt32(d, 0x2C);
        string name = ReadZ(d, Off(BitConverter.ToUInt64(d, 0x60)));
        long strTable = Off(BitConverter.ToUInt64(d, 0x68));
        uint strSize = BitConverter.ToUInt32(d, 0x70);
        int pages = (int)((strSize + 0x3FFF) / 0x4000);
        var strings = new List<string>();
        for (int i = 0; i < pages; i++) {
            long page = Off(BitConverter.ToUInt64(d, (int)(strTable + i * 8)));
            int len = (int)Math.Min(0x4000, strSize - (uint)(i * 0x4000));
            int s = 0;
            for (int j = 0; j < len; j++) {
                if (d[page + j] == 0) { if (j > s) strings.Add(Encoding.UTF8.GetString(d, (int)(page + s), j - s)); s = j + 1; }
            }
        }
        summary = string.Format("{0}\t{1}\t{2}\t{3}\t{4}\t{5}", name, codeLen, statics, globals & 0x3FFFF, natives, strings.Count);
        sb.AppendLine("name " + name); sb.AppendLine("code " + codeLen + " statics " + statics + " globals " + (globals & 0x3FFFF) + " globalblock " + (globals >> 18) + " natives " + natives);
        foreach (var x in strings) sb.AppendLine(x);
        return sb.ToString();
    }
    static string ReadZ(byte[] d, long o) { int e = (int)o; while (e < d.Length && d[e] != 0) e++; return Encoding.UTF8.GetString(d, (int)o, e - (int)o); }
}
"@

New-Item -ItemType Directory -Force $Out | Out-Null
$rel = "update\update2.rpf"
$rpf = New-Object CodeWalker.GameFiles.RpfFile((Join-Path $Game $rel), $rel)
$rpf.ScanStructure($null, $null)
$stack = New-Object System.Collections.Stack; $stack.Push($rpf)
$summary = New-Object System.Collections.Generic.List[string]
$summary.Add("name`tcode`tstatics`tglobals`tnatives`tstrings")
while ($stack.Count -gt 0) {
    $f = $stack.Pop()
    if ($f.Children) { foreach ($c in $f.Children) { $stack.Push($c) } }
    foreach ($e in $f.AllEntries) {
        if (-not ($e -is [CodeWalker.GameFiles.RpfFileEntry]) -or -not $e.NameLower.EndsWith(".ysc")) { continue }
        if ($e.NameLower -notlike "$Only.ysc") { continue }
        try {
            $raw = $f.ExtractFile($e)
            $data = [Ysc]::Inflate($raw)
            $s = $null
            $text = [Ysc]::Dump($data, [ref]$s)
            [IO.File]::WriteAllText((Join-Path $Out ($e.NameLower -replace '\.ysc$', '.txt')), $text)
            $summary.Add($s)
        } catch { Write-Host "$($e.Name): $($_.Exception.Message)" }
    }
}
$summary | Set-Content -Encoding UTF8 (Join-Path $Out "_summary.tsv")
Write-Host "$($summary.Count - 1) scripts dumped"
