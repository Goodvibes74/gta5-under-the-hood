# Read-only: native usage index for every game script, from the decompiled scripts clone at a pinned commit
# (git grep and git show; nothing is exported or copied). Each script's native table (native_tables/<script>.txt)
# lists the natives it imports by their NativeDB hash, so names come straight from NativeDB's natives.json; call
# counts come from the NS::NAME( calls in decompiled_scripts. Roadmap R0.3.
# Writes to <Out>: native-usage.tsv (one row per native: hash, namespace, name, build, scripts, calls, script list),
# script-natives.tsv (one row per script and native, with calls; about 46 MB), aliases.tsv, native-usage-index.md
# (summary) and native-usage\<NS>.md. The Markdown files are what this repo keeps in scripting/; copy them there.
# Query mode prints instead of writing: -Native <regex on NS::NAME> lists the scripts using each match; -Script <name>
# lists one script's natives.
# Needs NativeDB's natives.json, saved by hand from https://github.com/alloc8or/gta5-nativedb-data (this tool
# downloads nothing).
# Usage: powershell -NoProfile -ExecutionPolicy Bypass -File tools\native-usage.ps1 -NativesJson <file> -Out <folder>
#        powershell -NoProfile -ExecutionPolicy Bypass -File tools\native-usage.ps1 -NativesJson <file> -Native "CUTSCENE::START_CUTSCENE$"
# Takes about two minutes (12 million call sites). Guide: scripting/native-usage.md
param([string]$Repo = "..\GTA-V-Decompiled-Scripts", [string]$Commit = "6c18d3e8b",
      [Parameter(Mandatory = $true)][string]$NativesJson,
      # Where each native in the namespace pages links to: {ns}, {name} (lower case) and {hash} are filled in.
      [string]$LinkTemplate = "https://nativedb.dotindustries.dev/gta5/natives/{hash}", [string]$IndexName = "native-usage-index.md",
      [string]$Out, [string]$Native, [string]$Script)
$ErrorActionPreference = "Stop"
if (-not $Out -and -not $Native -and -not $Script) { throw "Give -Out, -Native or -Script." }

Add-Type -Language CSharp -TypeDefinition @"
using System; using System.Collections.Generic; using System.Diagnostics; using System.Text.RegularExpressions;
public static class NativeScan {
  // Runs git and streams its output line by line (12 million lines are too many for the PowerShell pipeline).
  public static void Git(string repo, string args, Action<string> onLine) {
    var psi = new ProcessStartInfo("git", "-C \"" + repo + "\" " + args) {
      UseShellExecute = false, RedirectStandardOutput = true, CreateNoWindow = true };
    psi.StandardOutputEncoding = System.Text.Encoding.UTF8;
    using (var p = Process.Start(psi)) { string l; while ((l = p.StandardOutput.ReadLine()) != null) onLine(l); p.WaitForExit(); }
  }
  // script -> hash list, from "<commit>:native_tables/<script>.txt:<hash>"
  public static Dictionary<string, List<string>> Tables(string repo, string commit) {
    var d = new Dictionary<string, List<string>>();
    Git(repo, "grep -e . --null " + commit + " -- native_tables", l => {
      int z = l.IndexOf('\0'); if (z < 0) return;
      string path = l.Substring(0, z), hash = l.Substring(z + 1).Trim().ToUpperInvariant();
      int s = path.LastIndexOf('/') + 1; string script = path.Substring(s, path.Length - s - 4);
      List<string> list; if (!d.TryGetValue(script, out list)) d[script] = list = new List<string>();
      list.Add(hash); });
    return d;
  }
  // "script\tNS::NAME" -> call count
  public static Dictionary<string, int> Calls(string repo, string commit) {
    var d = new Dictionary<string, int>();
    Git(repo, "grep --null -o -E \"\\b([A-Z_]+::[A-Za-z0-9_]+|unk_0x[0-9A-Fa-f]+)\\(\" " + commit + " -- decompiled_scripts", l => {
      int z = l.IndexOf('\0'); if (z < 0) return;
      string path = l.Substring(0, z); int s = path.LastIndexOf('/') + 1;
      // Name only, without the namespace or a leading underscore: the decompiler uses older namespace names
      // (CAM, PATHFIND, SYSTEM, APP) than NativeDB (CAMERA, PATH, BUILTIN, APPS). Natives the decompiler has no
      // name for appear as unk_0x<hash>( and are kept as "#<HASH>".
      string call = l.Substring(z + 1, l.Length - z - 2);
      call = call.StartsWith("unk_0x") ? "#" + call.Substring(6).ToUpperInvariant() : call.Substring(call.IndexOf("::") + 2).TrimStart('_');
      string key = path.Substring(s, path.Length - s - 2) + "\t" + call;
      int c; d.TryGetValue(key, out c); d[key] = c + 1; });
    return d;
  }
  // Decompiler name -> hash, for natives the decompiler names differently from NativeDB (older or other names).
  public static Dictionary<string, string> Aliases = new Dictionary<string, string>();
  // "script\tname" -> calls that stayed unresolved after aliasing.
  public static Dictionary<string, int> Unresolved = new Dictionary<string, int>();

  // hash -> (script, calls) for every script that imports it, busiest first. match: hash -> NativeDB name as
  // the scanner stores it. Within one script a decompile name resolves to an imported hash by alias first, then by
  // NativeDB name. Aliases are learned from scripts left with exactly one unresolved name and one uncalled hash,
  // repeated until nothing new is learned.
  public static Dictionary<string, List<KeyValuePair<string, int>>> PerNative(Dictionary<string, List<string>> tables,
      Dictionary<string, int> calls, System.Collections.Hashtable match) {
    var names = new Dictionary<string, Dictionary<string, int>>();   // script -> name -> calls
    foreach (var kv in calls) {
      int t = kv.Key.IndexOf('\t'); string sc = kv.Key.Substring(0, t);
      Dictionary<string, int> m; if (!names.TryGetValue(sc, out m)) names[sc] = m = new Dictionary<string, int>();
      m[kv.Key.Substring(t + 1)] = kv.Value; }
    var resolved = new Dictionary<string, Dictionary<string, string>>(); // script -> name -> hash
    bool learned = true;
    while (learned) {
      learned = false; resolved.Clear();
      foreach (var t in tables) {
        Dictionary<string, int> m; if (!names.TryGetValue(t.Key, out m)) m = new Dictionary<string, int>();
        var byName = new Dictionary<string, string>(); var inTable = new HashSet<string>(t.Value);
        foreach (var h in t.Value) byName[(string)match[h]] = h;
        var r = new Dictionary<string, string>(); var used = new HashSet<string>();
        foreach (var n in m.Keys) { string h = n.Substring(1);
          if (n[0] == '#' && inTable.Contains(h) && !used.Contains(h)) { r[n] = h; used.Add(h); } }
        foreach (var n in m.Keys) { string h;
          if (!r.ContainsKey(n) && Aliases.TryGetValue(n, out h) && inTable.Contains(h) && !used.Contains(h)) { r[n] = h; used.Add(h); } }
        foreach (var n in m.Keys) { string h;
          if (!r.ContainsKey(n) && byName.TryGetValue(n, out h) && !used.Contains(h)) { r[n] = h; used.Add(h); } }
        resolved[t.Key] = r;
        var leftN = new List<string>(); foreach (var n in m.Keys) if (!r.ContainsKey(n)) leftN.Add(n);
        var leftH = new List<string>(); foreach (var h in t.Value) if (!used.Contains(h)) leftH.Add(h);
        if (leftN.Count == 1 && leftH.Count == 1 && !Aliases.ContainsKey(leftN[0])) { Aliases[leftN[0]] = leftH[0]; learned = true; }
      }
    }
    var d = new Dictionary<string, List<KeyValuePair<string, int>>>();
    Unresolved.Clear();
    foreach (var t in tables) {
      Dictionary<string, int> m; if (!names.TryGetValue(t.Key, out m)) m = new Dictionary<string, int>();
      var r = resolved[t.Key]; var perHash = new Dictionary<string, int>();
      foreach (var n in m) { string h; if (r.TryGetValue(n.Key, out h)) perHash[h] = n.Value; else Unresolved[t.Key + "\t" + n.Key] = n.Value; }
      foreach (var h in t.Value) {
        int c; perHash.TryGetValue(h, out c);
        List<KeyValuePair<string, int>> list; if (!d.TryGetValue(h, out list)) d[h] = list = new List<KeyValuePair<string, int>>();
        list.Add(new KeyValuePair<string, int>(t.Key, c)); } }
    foreach (var l in d.Values) l.Sort((a, b) => b.Value != a.Value ? b.Value.CompareTo(a.Value) : string.CompareOrdinal(a.Key, b.Key));
    return d;
  }
}
"@

# NativeDB: hash -> namespace, name, first build. Hashes are stored as 0x + 16 hex digits.
$db = @{}
$json = Get-Content -Raw -Encoding UTF8 $NativesJson | ConvertFrom-Json
foreach ($ns in $json.PSObject.Properties) {
  foreach ($n in $ns.Value.PSObject.Properties) {
    $db[$n.Name.Substring(2).ToUpperInvariant()] = [pscustomobject]@{ Ns = $ns.Name; Name = $n.Value.name; Build = $n.Value.build } } }
$dbCount = $db.Count

$tables = [NativeScan]::Tables($Repo, $Commit)
$calls = [NativeScan]::Calls($Repo, $Commit)

# Per native: scripts that import it, and calls (decompile names matched to NativeDB's NS::NAME).
$usage = @{}
foreach ($kv in $tables.GetEnumerator()) {
  foreach ($h in $kv.Value) {
    if (-not $usage.ContainsKey($h)) { $usage[$h] = New-Object System.Collections.Generic.List[string] }
    $usage[$h].Add($kv.Key) } }
$full = @{}
foreach ($h in $usage.Keys) { if ($db.ContainsKey($h)) { $full[$h] = "$($db[$h].Ns)::$($db[$h].Name)" } else { $full[$h] = "UNKNOWN::_0x$h" } }
# Call-count key: the name without namespace or leading underscore, as the C# scanner stores it.
$match = @{}; foreach ($h in $full.Keys) { $match[$h] = ($full[$h] -replace "^[A-Z_]+::", "").TrimStart("_") }

$per = [NativeScan]::PerNative($tables, $calls, $match)

if ($Native) {
  foreach ($h in ($per.Keys | Where-Object { $full[$_] -match $Native } | Sort-Object { $full[$_] })) {
    "{0} (0x{1}): {2} scripts, {3} calls" -f $full[$h], $h, $per[$h].Count, ($per[$h] | Measure-Object Value -Sum).Sum
    $per[$h] | ForEach-Object { "  {0,-40} {1}" -f $_.Key, $_.Value } }
  return }
if ($Script) {
  if (-not $tables.ContainsKey($Script)) { throw "No native table for $Script" }
  $tables[$Script] | ForEach-Object { $h = $_; [pscustomobject]@{ Native = $full[$h]; Hash = "0x$h";
      Calls = ($per[$h] | Where-Object Key -eq $Script).Value } } |
    Sort-Object Native | Format-Table -AutoSize | Out-String -Width 200
  return }

New-Item -ItemType Directory -Force $Out, (Join-Path $Out "native-usage") | Out-Null

# Rows per native.
$rows = foreach ($h in $per.Keys) {
  $l = $per[$h]; $c = 0; foreach ($e in $l) { $c += $e.Value }
  $d = $db[$h]
  [pscustomobject]@{ Hash = "0x$h"; Ns = $(if ($d) { $d.Ns } else { "UNKNOWN" }); Name = $(if ($d) { $d.Name } else { "_0x$h" });
    Build = $(if ($d) { $d.Build } else { "" }); Scripts = $l.Count; Calls = $c; List = $l } }
$rows = $rows | Sort-Object Ns, Name
$rows | ForEach-Object { "{0}`t{1}`t{2}`t{3}`t{4}`t{5}`t{6}" -f $_.Hash, $_.Ns, $_.Name, $_.Build, $_.Scripts, $_.Calls, (($_.List | ForEach-Object Key) -join ",") } |
  Set-Content -Encoding UTF8 (Join-Path $Out "native-usage.tsv")
$sw = New-Object System.IO.StreamWriter((Join-Path $Out "script-natives.tsv"), $false, (New-Object System.Text.UTF8Encoding $false))
foreach ($r in $rows) { foreach ($e in $r.List) { $sw.WriteLine(("{0}`t{1}`t{2}::{3}`t{4}" -f $e.Key, $r.Hash, $r.Ns, $r.Name, $e.Value)) } }
$sw.Close()

# Matching check: decompile names that are not a NativeDB name of an imported hash.
$unmatched = @{}; foreach ($kv in [NativeScan]::Unresolved.GetEnumerator()) { $n = ($kv.Key -split "`t")[1]; $unmatched[$n] = $kv.Value + [int]$unmatched[$n] }
$aliases = [NativeScan]::Aliases
$aliases.GetEnumerator() | Sort-Object Key | ForEach-Object { "{0}`t0x{1}`t{2}" -f $_.Key, $_.Value, $full[$_.Value] } |
  Set-Content -Encoding UTF8 (Join-Path $Out "aliases.tsv")

# Summary page.
$md = New-Object System.Text.StringBuilder
function L([string]$s) { [void]$md.AppendLine($s) }
$totalCalls = ($rows | Measure-Object Calls -Sum).Sum
L "# Native usage index"
L ""
L ("Generated by ``tools/native-usage.ps1`` from the decompile at commit ``{0}`` (build 3725) and NativeDB's ``natives.json`` ({1} natives). {2} scripts have a native table; together they import **{3} distinct natives** and make **{4:N0} native calls**. Imported natives missing from NativeDB: {5}. Decompile names with no imported hash: {6}." -f $Commit, $dbCount, $tables.Count, $rows.Count, $totalCalls, ($rows | Where-Object Ns -eq "UNKNOWN").Count, $unmatched.Count)
L ""
L "## By namespace"
L ""
L "| Namespace | In NativeDB | Used by scripts | Never used by a script | Calls | Busiest native (scripts) |"
L "| --- | ---: | ---: | ---: | ---: | --- |"
$dbByNs = $db.Values | Group-Object Ns -AsHashTable -AsString
foreach ($g in ($rows | Group-Object Ns | Sort-Object { ($_.Group | Measure-Object Calls -Sum).Sum } -Descending)) {
  $inDb = if ($dbByNs.ContainsKey($g.Name)) { $dbByNs[$g.Name].Count } else { 0 }
  $top = $g.Group | Sort-Object Scripts -Descending | Select-Object -First 1
  L ("| [{0}](native-usage/{0}.md) | {1} | {2} | {3} | {4:N0} | ``{5}`` ({6}) |" -f $g.Name, $inDb, $g.Count, ([math]::Max(0, $inDb - $g.Count)), ($g.Group | Measure-Object Calls -Sum).Sum, $top.Name, $top.Scripts) }
L ""
L "## The 40 natives used by the most scripts"
L ""
L "| Native | Scripts | Calls |"
L "| --- | ---: | ---: |"
$rows | Sort-Object Scripts, Calls -Descending | Select-Object -First 40 | ForEach-Object { L ("| ``{0}::{1}`` | {2} | {3:N0} |" -f $_.Ns, $_.Name, $_.Scripts, $_.Calls) }
L ""
L "## The 40 most-called natives"
L ""
L "| Native | Calls | Scripts |"
L "| --- | ---: | ---: |"
$rows | Sort-Object Calls -Descending | Select-Object -First 40 | ForEach-Object { L ("| ``{0}::{1}`` | {2:N0} | {3} |" -f $_.Ns, $_.Name, $_.Calls, $_.Scripts) }
L ""
L "## Scripts with the most natives"
L ""
L "| Script | Natives imported |"
L "| --- | ---: |"
$tables.GetEnumerator() | Sort-Object { $_.Value.Count } -Descending | Select-Object -First 25 | ForEach-Object { L ("| ``{0}`` | {1} |" -f $_.Key, $_.Value.Count) }
L ""
L "## Names the decompiler uses differently from NativeDB"
L ""
L ("{0} decompile names were matched to a hash by elimination (a script left with one unmatched name and one uncalled import). Full list: ``aliases.tsv``." -f $aliases.Count)
if ($unmatched.Count) {
  L ""; L "## Decompile names left unresolved (calls)"; L ""
  L (($unmatched.GetEnumerator() | Sort-Object Value -Descending | ForEach-Object { "``$($_.Key)`` ($($_.Value))" }) -join ", ") }
$md.ToString() | Set-Content -Encoding UTF8 (Join-Path $Out $IndexName)

# One page per namespace: every imported native, with up to 12 scripts (busiest first).
foreach ($g in ($rows | Group-Object Ns)) {
  $p = New-Object System.Text.StringBuilder
  [void]$p.AppendLine("# $($g.Name) natives used by the game scripts")
  [void]$p.AppendLine("")
  [void]$p.AppendLine("Build 3725, decompile commit ``$Commit``, generated by ``tools/native-usage.ps1``. Full script list for one native: ``tools/native-usage.ps1 -Native `"$($g.Name)::NAME`$`"``. Back to the [index](../$IndexName).")
  [void]$p.AppendLine("")
  [void]$p.AppendLine("| Native | Hash | Since build | Scripts | Calls | Used by (busiest first) |")
  [void]$p.AppendLine("| --- | --- | --- | ---: | ---: | --- |")
  foreach ($r in $g.Group) {
    $top = $r.List | Select-Object -First 12 | ForEach-Object Key
    $more = if ($r.Scripts -gt 12) { " +$($r.Scripts - 12)" } else { "" }
    $cell = if ($g.Name -eq "UNKNOWN") { "``$($r.Name)``" } else {   # not in NativeDB: nothing to link to
      "[``$($r.Name)``]($($LinkTemplate.Replace('{ns}', $g.Name).Replace('{name}', $r.Name.ToLowerInvariant()).Replace('{hash}', $r.Hash)))" }
    [void]$p.AppendLine(("| {0} | ``{1}`` | {2} | {3} | {4:N0} | {5}{6} |" -f $cell, $r.Hash, $r.Build, $r.Scripts, $r.Calls, ($top -join ", "), $more)) }
  $p.ToString() | Set-Content -Encoding UTF8 (Join-Path $Out "native-usage\$($g.Name).md") }

"{0} scripts, {1} natives imported ({2} unknown to NativeDB), {3:N0} calls, {4} unmatched decompile names -> {5}" -f $tables.Count, $rows.Count,
  ($rows | Where-Object Ns -eq "UNKNOWN").Count, $totalCalls, $unmatched.Count, $Out
