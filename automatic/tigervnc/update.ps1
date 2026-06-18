$ErrorActionPreference = 'Stop'
import-module chocolatey-AU
$curDir	= "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$toolsDir = Join-Path $curDir "tools"
$releases 	= 'https://sourceforge.net/projects/tigervnc/rss?path=/stable'
$options 	=
@{
  Headers = @{
    UserAgent = 'Wget';
  }
}

function global:au_SearchReplace {
	@{
		"legal\VERIFICATION.txt"      = @{
			"(?i)(link32:).*"        			= "`${1} $($Latest.URL32)"
			"(?i)(checksum32:).*" 				= "`${1} $($Latest.Checksum32)"
			"(?i)(checksumtype:).*" 			= "`${1} $($Latest.ChecksumType32)"
			"(?i)(link64:).*"        			= "`${1} $($Latest.URL64)"
			"(?i)(checksum64:).*" 				= "`${1} $($Latest.Checksum64)"
		}
		"$($Latest.PackageName).nuspec" = @{
			"(\<releaseNotes\>).*?(\</releaseNotes\>)"		= "`${1}https://github.com/TigerVNC/tigervnc/releases/tag/$($Latest.Version)`$2"
		}
	}
}

function global:au_BeforeUpdate {
	if (-not (Test-Path "tools")) {
		New-Item -ItemType Directory -Path "tools" | Out-Null
	}

	. ..\..\scripts\Get-FileVersion.ps1
	$FileVersion = Get-FileVersion $Latest.URL32 -keep
	Move-Item -Path $FileVersion.TempFile -Destination "tools\tigervnc.exe" -Force
	$FileVersion64 = Get-FileVersion $Latest.URL64 -keep
	Move-Item -Path $FileVersion64.TempFile -Destination "tools\tigervnc64.exe" -Force

	$Latest.Checksum32     = $FileVersion.Checksum
	$Latest.ChecksumType32 = $FileVersion.ChecksumType
	$Latest.Checksum64     = $FileVersion64.Checksum
	$Latest.ChecksumType64 = $FileVersion64.ChecksumType
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

	# Extract version from URL path (e.g. .../stable/1.16.2/tigervnc-1.16.2.exe/download)
	# Do NOT call Get-RedirectedUrl here — it returns CDN mirror URLs with query params
	# (?ts=...&use_mirror=...) that WebClient.DownloadFile treats as illegal path characters,
	# breaking the AU retry loop and the VirusTotal scan (Get-RemoteFiles). Keep the permanent
	# SourceForge /download URLs; Invoke-WebRequest follows the redirect automatically.
	$versionMatch = [regex]::Match($url32, '/stable/([^/]+)/')
	if (-not $versionMatch.Success) {
		throw "Could not extract version from URL: $url32"
	}
	$version = $versionMatch.Groups[1].Value

	return @{
		URL32      = $url32
		URL64      = $url64
		Version    = $version
		FileName32 = 'tigervnc.exe'
		FileName64 = 'tigervnc64.exe'
	}
}

update -ChecksumFor none -NoCheckChocoVersion
