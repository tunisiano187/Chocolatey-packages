$ErrorActionPreference = 'Stop'
import-module chocolatey-AU
Import-Module ..\..\scripts\au_extensions.psm1

$releases = 'https://www.stompsoftware.com/downloads/'

function global:au_SearchReplace {
	@{
		'tools/chocolateyInstall.ps1' = @{
			"(^[$]url\s*=\s*)('.*')"      		= "`$1'$($Latest.URL32)'"
			"(^[$]checksum\s*=\s*)('.*')" 		= "`$1'$($Latest.Checksum32)'"
			"(^[$]checksumType\s*=\s*)('.*')" 	= "`$1'$($Latest.ChecksumType32)'"
		}
	}
}

function global:au_BeforeUpdate {
	. ..\..\scripts\Get-FileVersion.ps1
	$FileVersion = Get-FileVersion -url $Latest.URL32 -checksumType 'sha256'
	$Latest.Checksum32 = $FileVersion.Checksum
	$Latest.ChecksumType32 = $FileVersion.ChecksumType
}

function global:au_AfterUpdate($Package) {
	Invoke-VirusTotalScan $Package
}

function global:au_GetLatest {
	$url32 = 'https://stompsoftware.com/downloadfiles/albumstomp/SetupAlbumStompV2.exe'

	$pageContent = Invoke-WebRequest -Uri $releases -UseBasicParsing
	$regexPattern = 'Version (\d+(\.\d+)*)'
	$versionMatch = $pageContent.Content | Select-String -Pattern $regexPattern -AllMatches

	$baseVersion = $versionMatch.Matches[1].Groups[1].Value
	$version = $baseVersion

	# CHO-687: the vendor replaced SetupAlbumStompV2.exe at this same rolling URL without
	# bumping the "Version X.Y" text on the downloads page, so AU never noticed the file
	# changed and the committed checksum went stale. Same technique already used for
	# anyvideoconverter/windjview/cports/projectlibre.install in this repo: keep the page's
	# own version as a fixed base and only append a date suffix when the freshly-downloaded
	# checksum differs from what's already committed, so AU detects an update on its own and
	# au_BeforeUpdate (above) recomputes the checksum -- it isn't hand-patched here.
	# Scoped to 2.40 only: if stompsoftware.com ever properly bumps the version text, that
	# change alone already makes AU push normally and this workaround should stay out of it.
	if ($baseVersion -eq '2.40') {
		. ..\..\scripts\Get-FileVersion.ps1
		$FileVersion = Get-FileVersion -url $url32 -checksumType 'sha256'
		$installContent = Get-Content "$PSScriptRoot\tools\chocolateyinstall.ps1" -Raw
		$current_checksum = [regex]::Match($installContent, "\`$checksum\s*=\s*'([a-fA-F0-9]+)'").Groups[1].Value
		if ($current_checksum -and $current_checksum -ne $FileVersion.Checksum) {
			try {
				$lastModified = (Invoke-WebRequest -Uri $url32 -Method Head -UseBasicParsing).Headers['Last-Modified']
				$dateStamp = ([datetime]::Parse($lastModified)).ToString('yyyyMMdd')
			} catch {
				$dateStamp = Get-Date -Format 'yyyyMMdd'
			}
			$version = "$baseVersion.$dateStamp"
		}
	}

	return @{ URL32 = $url32; Version = $version }
}

update -ChecksumFor none
