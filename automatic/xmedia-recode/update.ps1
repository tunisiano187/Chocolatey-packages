$ErrorActionPreference = 'Stop'
import-module chocolatey-AU

$releases = 'https://www.xmedia-recode.de/en/index.php'

function global:au_SearchReplace {
	@{
		"legal\VERIFICATION.txt"      = @{
			"(?i)(x32:).*"        				= "`${1} $($Latest.URL32)"
			"(?i)(checksum32:).*" 				= "`${1} $($Latest.Checksum32)"
			"(?i)(x64:).*"        				= "`${1} $($Latest.URL64)"
			"(?i)(checksum64:).*" 				= "`${1} $($Latest.Checksum64)"
			"(?i)(checksumtype:).*" 			= "`${1} $($Latest.ChecksumType32)"
		}
	}
}

function global:au_BeforeUpdate {
	. ..\..\scripts\Get-FileVersion.ps1
	$FileVersion = Get-FileVersion $Latest.URL32 -keep
	Move-Item $FileVersion.TempFile -Destination "tools\XMediaRecode_setup.exe"
	$Latest.Checksum32 = $FileVersion.Checksum
	$Latest.ChecksumType32 = $FileVersion.checksumType
	$FileVersion = Get-FileVersion $Latest.URL64 -keep
	Move-Item $FileVersion.TempFile -Destination "tools\XMediaRecode_x64_setup.exe"
	$Latest.Checksum64 = $FileVersion.Checksum
	$Latest.ChecksumType64 = $FileVersion.checksumType
}

function global:au_AfterUpdate($Package) {
	. ..\..\scripts\Invoke-VirusTotalScan.ps1
	Invoke-VirusTotalScan $Package
}

function global:au_GetLatest {
	$page = Invoke-WebRequest -Uri $releases -UseBasicParsing
	$regexPattern = 'XMedia Recode (\d+\.\d+(\.\d+)*)'
	$versionMatch = $page.Content | Select-String -Pattern $regexPattern -AllMatches

	if (-not $versionMatch.Matches -or $versionMatch.Matches.Count -eq 0) {
		throw "Could not find version pattern in page content"
	}

	$version = $versionMatch.Matches[0].Groups[1].Value

	if (-not $version -or $version -eq "" -or $version -match '^\d{2}$') {
		throw "Invalid version extracted: '$version'"
	}

	# Scrape the actual download URLs from each download page (32-bit and 64-bit have independent file versioning)
	$page64 = Invoke-WebRequest -Uri "https://www.xmedia-recode.de/en/download-64bit.php" -UseBasicParsing
	$url64 = ($page64.Links | Where-Object {$_.href -match 'XMediaRecode\d+_x64_setup\.exe$'} | Select-Object -First 1).href

	$page32 = Invoke-WebRequest -Uri "https://www.xmedia-recode.de/en/download-32bit.php" -UseBasicParsing
	$url32 = ($page32.Links | Where-Object {$_.href -match 'XMediaRecode\d+_setup\.exe$' -and $_.href -notmatch '_x64_'} | Select-Object -First 1).href

	if (-not $url64) {
		throw "Could not find 64-bit download URL on xmedia-recode.de"
	}
	if (-not $url32) {
		$url32 = $url64  # fall back to 64-bit if 32-bit is gone
	}

	$Latest = @{ URL32 = $url32; URL64 = $url64; Version = $version }
	return $Latest
}

update -ChecksumFor none
