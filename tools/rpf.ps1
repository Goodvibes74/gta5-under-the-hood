<#
.SYNOPSIS
    Read-only viewer for unencrypted ("OPEN") GTA V RPF7 archives.

.DESCRIPTION
    Lists the contents of an RPF archive (including nested .rpf archives) and
    extracts plain files such as dlclist.xml, vehicles.meta or handling.meta.
    It never writes to an archive. Edits still go through OpenIV.

    Lists any archive whose file table is unencrypted ("OPEN"): everything in an
    OpenIV mods folder and the vanilla update/update.rpf. Rockstar files inside stay encrypted one by one,
    so only add-on packs and files replaced with OpenIV can be extracted. Encrypted archives (the vanilla root x64*.rpf and common.rpf)
    are reported and skipped; use rpf-cw.ps1 (CodeWalker) for those.

    Resource files (.ytd, .yft, .ydr, .ymap, ...) are listed but not extracted,
    because they are compiled binary assets that need OpenIV or CodeWalker.

.EXAMPLE
    powershell -NoProfile -ExecutionPolicy Bypass -File tools/rpf.ps1 list update/update.rpf "*dlclist*"

.EXAMPLE
    powershell -NoProfile -ExecutionPolicy Bypass -File tools/rpf.ps1 extract mods/update/x64/dlcpacks/<addon-pack>/dlc.rpf "*.meta" -Out "$env:TEMP\rpf"
#>
param(
    [Parameter(Mandatory = $true, Position = 0)]
    [ValidateSet('list', 'extract')]
    [string]$Command,

    [Parameter(Mandatory = $true, Position = 1)]
    [string]$Archive,

    # Wildcard matched against the path inside the archive, e.g. "*dlclist.xml" or "*/data/*.meta".
    [Parameter(Position = 2)]
    [string]$Pattern = '*',

    # Folder to extract into. Defaults to %TEMP%\rpf-extract\<archive name>.
    [string]$Out,

    # Don't look inside nested .rpf archives.
    [switch]$NoRecurse
)

$ErrorActionPreference = 'Stop'

if (-not ('RpfTool.Reader' -as [type])) {
    Add-Type -Language CSharp -TypeDefinition @'
using System;
using System.Collections.Generic;
using System.IO;
using System.IO.Compression;
using System.Text;

namespace RpfTool
{
    public class Entry
    {
        public string Path;
        public string Kind;          // file, resource, archive
        public long Offset;          // absolute byte offset in the outer file
        public uint StoredSize;      // bytes on disk
        public uint Size;            // uncompressed size (files only)
        public bool Compressed;
        public bool Encrypted;
    }

    public static class Reader
    {
        const uint Magic = 0x52504637;  // "RPF7"
        const uint Open = 0x4E45504F;   // "OPEN": no encryption
        const uint DirIdent = 0x7FFFFF00;

        public static List<Entry> Read(FileStream fs, bool recurse, List<string> warnings)
        {
            var result = new List<Entry>();
            ReadArchive(fs, 0, "", recurse, result, warnings);
            return result;
        }

        static bool ReadArchive(FileStream fs, long start, string prefix, bool recurse, List<Entry> result, List<string> warnings)
        {
            var br = new BinaryReader(fs);
            fs.Position = start;
            uint magic = br.ReadUInt32();
            uint count = br.ReadUInt32();
            uint namesLength = br.ReadUInt32();
            uint encryption = br.ReadUInt32();
            string label = prefix.Length == 0 ? "archive" : prefix.TrimEnd('/');

            if (magic != Magic)
            {
                warnings.Add(label + ": not an RPF7 archive, skipped");
                return false;
            }
            if (encryption != Open)
            {
                // Nested archives are flagged on their entry instead of warned about one by one.
                if (prefix.Length == 0) warnings.Add(label + ": encrypted (0x" + encryption.ToString("X8") + "), skipped. Use CodeWalker for this one.");
                return false;
            }

            byte[] entries = br.ReadBytes((int)(count * 16));
            byte[] names = br.ReadBytes((int)namesLength);
            WalkDirectory(fs, start, entries, names, 0, prefix, recurse, result, warnings);
            return true;
        }

        static void WalkDirectory(FileStream fs, long start, byte[] entries, byte[] names, uint dirIndex,
            string prefix, bool recurse, List<Entry> result, List<string> warnings)
        {
            int d = (int)dirIndex * 16;
            uint first = BitConverter.ToUInt32(entries, d + 8);
            uint childCount = BitConverter.ToUInt32(entries, d + 12);

            for (uint i = first; i < first + childCount; i++)
            {
                int e = (int)i * 16;
                uint ident = BitConverter.ToUInt32(entries, e + 4);

                if (ident == DirIdent)
                {
                    string dirName = ReadName(names, BitConverter.ToUInt32(entries, e));
                    WalkDirectory(fs, start, entries, names, i, prefix + dirName + "/", recurse, result, warnings);
                    continue;
                }

                ulong buf = BitConverter.ToUInt64(entries, e);
                string name = ReadName(names, (uint)(buf & 0xFFFF));
                var entry = new Entry();
                entry.Path = prefix + name;
                uint storedSize = (uint)((buf >> 16) & 0xFFFFFF);

                if ((ident & 0x80000000) == 0)
                {
                    // Binary file: stored as-is when storedSize is 0, otherwise raw deflate.
                    entry.Offset = start + (long)((buf >> 40) & 0xFFFFFF) * 512;
                    entry.Size = BitConverter.ToUInt32(entries, e + 8);
                    entry.Encrypted = BitConverter.ToUInt32(entries, e + 12) != 0;
                    entry.Compressed = storedSize != 0;
                    entry.StoredSize = entry.Compressed ? storedSize : entry.Size;
                    entry.Kind = name.EndsWith(".rpf", StringComparison.OrdinalIgnoreCase) ? "archive" : "file";
                }
                else
                {
                    // Resource (compiled asset with an RSC7 header).
                    entry.Offset = start + (long)((buf >> 40) & 0x7FFFFF) * 512;
                    entry.Kind = "resource";
                    if (storedSize == 0xFFFFFF)
                    {
                        // Large resource: the real size is spread over the RSC7 header.
                        long keep = fs.Position;
                        fs.Position = entry.Offset;
                        byte[] h = new byte[16];
                        fs.Read(h, 0, 16);
                        fs.Position = keep;
                        storedSize = (uint)h[7] | ((uint)h[14] << 8) | ((uint)h[5] << 16) | ((uint)h[2] << 24);
                    }
                    entry.StoredSize = storedSize;
                    entry.Size = storedSize;
                }

                result.Add(entry);

                if (entry.Kind == "archive" && recurse && !entry.Encrypted)
                {
                    if (!ReadArchive(fs, entry.Offset, entry.Path + "/", true, result, warnings)) entry.Encrypted = true;
                }
            }
        }

        static string ReadName(byte[] names, uint offset)
        {
            int end = (int)offset;
            while (end < names.Length && names[end] != 0) end++;
            return Encoding.ASCII.GetString(names, (int)offset, end - (int)offset);
        }

        public static byte[] Extract(FileStream fs, Entry entry)
        {
            fs.Position = entry.Offset;
            byte[] stored = new byte[entry.StoredSize];
            int read = 0;
            while (read < stored.Length)
            {
                int n = fs.Read(stored, read, stored.Length - read);
                if (n <= 0) throw new EndOfStreamException(entry.Path);
                read += n;
            }
            if (!entry.Compressed) return stored;

            using (var input = new MemoryStream(stored))
            using (var deflate = new DeflateStream(input, CompressionMode.Decompress))
            using (var output = new MemoryStream((int)entry.Size))
            {
                deflate.CopyTo(output);
                return output.ToArray();
            }
        }
    }
}
'@
}

$archivePath = (Resolve-Path -LiteralPath $Archive).Path
$fs = [System.IO.File]::Open($archivePath, 'Open', 'Read', 'ReadWrite')
try {
    $warnings = New-Object 'System.Collections.Generic.List[string]'
    $entries = [RpfTool.Reader]::Read($fs, -not $NoRecurse, $warnings)
    $matched = @($entries | Where-Object { $_.Path -like $Pattern })

    if ($Command -eq 'list') {
        foreach ($e in $matched) {
            $flag = if ($e.Encrypted) { ' (encrypted)' } else { '' }
            '{0,-9} {1,12:N0}  {2}{3}' -f $e.Kind, $e.Size, $e.Path, $flag
        }
        $locked = @($matched | Where-Object { $_.Encrypted }).Count
        '{0} of {1} entries matched, {2} of them encrypted (contents not readable; use rpf-cw.ps1)' -f $matched.Count, $entries.Count, $locked
    }
    else {
        if (-not $Out) {
            $Out = Join-Path $env:TEMP ('rpf-extract\' + [System.IO.Path]::GetFileNameWithoutExtension($archivePath))
        }
        $done = 0
        foreach ($e in $matched) {
            if ($e.Kind -ne 'file') { continue }
            if ($e.Encrypted) { $warnings.Add($e.Path + ': file is encrypted, skipped'); continue }
            $target = Join-Path $Out ($e.Path -replace '/', '\')
            [void](New-Item -ItemType Directory -Force -Path (Split-Path $target))
            [System.IO.File]::WriteAllBytes($target, [RpfTool.Reader]::Extract($fs, $e))
            $target
            $done++
        }
        '{0} file(s) extracted to {1} (resources and nested archives are skipped)' -f $done, $Out
    }

    foreach ($w in $warnings) { Write-Warning $w }
}
finally {
    $fs.Dispose()
}
