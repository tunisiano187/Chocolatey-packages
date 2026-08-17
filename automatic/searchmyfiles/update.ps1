$ErrorActionPreference = 'Stop'
import-module chocolatey-AU

function global:au_SearchReplace {
	@{
		"legal\VERIFICATION.txt"      = @{
			"(?i)(x86:).*"        				= "`${1} $($Latest.URL32)"
			"(?i)(checksum:).*" 				= "`${1} $($Latest.Checksum32)"
			"(?i)(x64:).*"        				= "`${1} $($Latest.URL64)"
			"(?i)(checksum64:).*" 				= "`${1} $($Latest.Checksum64)"
		}
	}
}

function global:au_BeforeUpdate {
	. ..\..\scripts\Get-FileVersion.ps1
	$FileVersion = Get-FileVersion $Latest.URL32 -keep
	Move-Item -Path $FileVersion.TempFile -Destination "tools/searchmyfiles.zip"
	$Latest.Checksum32 = $FileVersion.Checksum
	$Latest.ChecksumType32 = $FileVersion.checksumType
	$FileVersion = Get-FileVersion $Latest.URL64 -keep
	Move-Item -Path $FileVersion.TempFile -Destination "tools/searchmyfiles-x64.zip"
	$Latest.Checksum64 = $FileVersion.Checksum
	$Latest.ChecksumType64 = $FileVersion.checksumType

	# Without this, Invoke-VirusTotalScan (called from au_AfterUpdate below) treats unset
	# FileName32/FileName64 as "no file tracked yet for this package" -- it re-downloads its
	# own scratch copies via Get-RemoteFiles purely to scan them, then DELETES whatever it
	# downloaded once the scan is done. That's correct for download-on-install packages, but
	# both zips here are embedded by au_BeforeUpdate above, so the deletion strips the real
	# files chocolateyInstall.ps1 needs. Confirmed live: v3.36.0 failed verification with
	# "Get-ChocolateyUnzip: The system cannot find the file specified" for
	# searchmyfiles-x64.zip -- same root cause already fixed for osfmount/freeplane this way.
	$Latest.FileName32 = 'searchmyfiles.zip'
	$Latest.FileName64 = 'searchmyfiles-x64.zip'
}

function global:au_AfterUpdate($Package) {
	. ..\..\scripts\Invoke-VirusTotalScan.ps1
	Invoke-VirusTotalScan $Package
}

function global:au_GetLatest {
	$url32 = "https://www.nirsoft.net/utils/searchmyfiles.zip"
	$url64 = "https://www.nirsoft.net/utils/searchmyfiles-x64.zip"
	$pageContent = Invoke-WebRequest -Uri "https://www.nirsoft.net/utils/search_my_files.html" -UseBasicParsing
	$regexPattern = 'SearchMyFiles v(\d+(\.\d+)*)'
	$versionMatch = $pageContent.Content | Select-String -Pattern $regexPattern -AllMatches
	$version = $versionMatch.Matches[0].Groups[1].Value
	Update-Metadata -key "copyright" -value "(c) $(Get-Date -Format "yyyy") NirSoft"

	$Latest = @{ URL32 = $url32; URL64 = $url64; Version = $version }
	return $Latest
}

update -ChecksumFor none -NoCheckChocoVersion
