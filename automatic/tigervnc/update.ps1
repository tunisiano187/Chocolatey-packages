$ErrorActionPreference = 'Stop'
import-module chocolatey-AU
$releases = 'https://sourceforge.net/projects/tigervnc/rss?path=/stable'

function global:au_SearchReplace {
	@{
		'tools/chocolateyInstall.ps1' = @{
			"(url\s*=\s*)'.*'"             = "`$1'$($Latest.URL32)'"
			"(url64bit\s*=\s*)'.*'"        = "`$1'$($Latest.URL64)'"
			"(checksum\s*=\s*)'.*'"        = "`$1'$($Latest.Checksum32)'"
			"(checksumType\s*=\s*)'.*'"    = "`$1'$($Latest.ChecksumType32)'"
			"(checksum64\s*=\s*)'.*'"      = "`$1'$($Latest.Checksum64)'"
			"(checksumType64\s*=\s*)'.*'"  = "`$1'$($Latest.ChecksumType64)'"
		}
		"legal\VERIFICATION.txt" = @{
			"(?i)(link32:).*"       = "`${1} $($Latest.URL32)"
			"(?i)(checksum32:).*"   = "`${1} $($Latest.Checksum32)"
			"(?i)(checksumtype:).*" = "`${1} $($Latest.ChecksumType32)"
			"(?i)(link64:).*"       = "`${1} $($Latest.URL64)"
			"(?i)(checksum64:).*"   = "`${1} $($Latest.Checksum64)"
		}
		"$($Latest.PackageName).nuspec" = @{
			"(\<releaseNotes\>).*?(\</releaseNotes\>)" = "`${1}https://github.com/TigerVNC/tigervnc/releases/tag/$($Latest.Version)`$2"
		}
	}
}

function global:au_AfterUpdate($Package) {
	. ..\..\scripts\Invoke-VirusTotalScan.ps1
	Invoke-VirusTotalScan $Package
}

function global:au_GetLatest {
	$File = "$env:TEMP\tigervnc.xml"
	Invoke-WebRequest -Uri $releases -OutFile $File
	$xml = Get-Content $File

	# Extract download links from RSS <link> tags (SourceForge RSS uses <link> not href)
	$links = @()
	$linkPattern = '<link>(https://sourceforge\.net/projects/tigervnc/files/[^<]*\.exe/download)</link>'
	$linkMatches = [regex]::Matches($xml, $linkPattern)

	foreach ($match in $linkMatches) {
		$links += $match.Groups[1].Value
	}

	if ($links.Count -lt 2) {
		throw "Could not find download links in RSS feed (found $($links.Count))"
	}

	$url32 = $links | Where-Object {$_ -match 'tigervnc-[0-9]'} | Select-Object -First 1
	$url64 = $links | Where-Object {$_ -match 'tigervnc64-[0-9]'} | Select-Object -First 1

	if (-not $url32 -or -not $url64) {
		throw "Could not find both 32-bit and 64-bit download links"
	}

	# Do NOT call Get-RedirectedUrl here — it returns CDN mirror URLs with query params
	# (?ts=...&use_mirror=...) that WebClient.DownloadFile treats as illegal path characters,
	# breaking the AU retry loop and the VirusTotal scan (Get-RemoteFiles). Keep the permanent
	# SourceForge /download URLs; Invoke-WebRequest follows the redirect automatically.

	# Extract version from URL path (e.g. .../stable/1.16.2/tigervnc64-1.16.2.exe/download)
	$version = [regex]::Match($url64, '/stable/([^/]+)/').Groups[1].Value

	if (-not $version) {
		throw "Could not extract version from URL: $url64"
	}

	. ..\..\scripts\Get-FileVersion.ps1
	$fv32 = Get-FileVersion $url32
	$fv64 = Get-FileVersion $url64

	return @{
		URL32          = $url32
		URL64          = $url64
		Version        = $version
		Checksum32     = $fv32.Checksum
		ChecksumType32 = $fv32.ChecksumType
		Checksum64     = $fv64.Checksum
		ChecksumType64 = $fv64.ChecksumType
	}
}

update -ChecksumFor none -NoCheckChocoVersion
