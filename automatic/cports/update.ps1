$ErrorActionPreference = 'Stop'
import-module chocolatey-AU

Add-Type -AssemblyName System.IO.Compression.FileSystem
function global:au_SearchReplace {
	@{
		'tools/chocolateyInstall.ps1' = @{
			"(^[$]url\s*=\s*)('.*')"      = "`$1'$($Latest.URL32)'"
			"(^[$]checksum\s*=\s*)('.*')" = "`$1'$($Latest.Checksum32)'"
			"(^[$]checksumType\s*=\s*)('.*')" = "`$1'$($Latest.ChecksumType32)'"
			"(^[$]url64\s*=\s*)('.*')"      = "`$1'$($Latest.URL64)'"
			"(^[$]checksum64\s*=\s*)('.*')" = "`$1'$($Latest.Checksum64)'"
			"(^[$]checksumType64\s*=\s*)('.*')" = "`$1'$($Latest.ChecksumType64)'"
		}
	}
}

function global:au_AfterUpdate($Package) {
	Import-Module ..\..\scripts\au_extensions.psm1
	Invoke-VirusTotalScan $Package
}

function global:au_GetLatest {
	$url32 = 'https://www.nirsoft.net/utils/cports.zip'
	$url64 = 'https://www.nirsoft.net/utils/cports-x64.zip'
	$page=Invoke-WebRequest -Uri "https://www.nirsoft.net/utils/" -UseBasicParsing
	$regexPattern = 'CurrPorts\ v(\d+(\.\d+)*)'
	$versionMatch = $page.Content | Select-String -Pattern $regexPattern -AllMatches
	$version = $versionMatch.Matches[0].Groups[1].Value

	# nirsoft.net doesn't bump the CurrPorts version string on every silent binary refresh, and
	# the single-package push handler in .appveyor.yml doesn't commit back to git (same root
	# cause documented for netbeans/projectlibre.install) -- so the nuspec stays at 0.0 forever
	# and a bare version-string comparison always looks "new" even when nothing changed, hitting
	# 409 Conflict every run. Compare the freshly-downloaded checksum against what's already
	# committed in chocolateyInstall.ps1 instead -- ground truth for "did the binary actually
	# change" -- and only bump when it genuinely has (same technique already used by windjview
	# in this repo), using the zip's own Last-Modified date rather than "today" so re-checks
	# before a successful commit lands don't each mint a further new version.
	#
	# This alone isn't enough, though: since the nuspec never advances off 0.0 either way, every
	# subsequent run recomputes the exact same version (same stale committed checksum, same
	# unchanged Last-Modified date) and, with -NoCheckChocoVersion still forcing a push attempt
	# regardless, keeps re-pushing a version that already succeeded once -- 409 forever, just on
	# a fixed version instead of a new one each day (confirmed live: exactly this, the day after
	# this technique first shipped). -NoCheckChocoVersion is removed below for that reason: AU's
	# own default check against the live chocolatey.org feed correctly recognizes an
	# already-published version and skips cleanly, with no error and no push attempt, and still
	# lets a genuinely new future version through untouched.
	. ..\..\scripts\Get-FileVersion.ps1
	$fileVersion64 = Get-FileVersion $url64 -checksumType 'sha256'
	$installContent = Get-Content "$PSScriptRoot\tools\chocolateyInstall.ps1" -Raw
	$current_checksum64 = [regex]::Match($installContent, "\`$checksum64\s*=\s*'([a-fA-F0-9]+)'").Groups[1].Value
	if ($current_checksum64 -and $current_checksum64 -ne $fileVersion64.Checksum) {
		try {
			$lastModified = (Invoke-WebRequest -Uri $url64 -Method Head -UseBasicParsing).Headers['Last-Modified']
			$dateStamp = ([datetime]::Parse($lastModified)).ToString('yyyyMMdd')
		} catch {
			$dateStamp = Get-Date -Format 'yyyyMMdd'
		}
		$version = "$version.$dateStamp"
	}

	$Latest = @{ URL32 = $url32; URL64 = $url64; Version = $version }
	return $Latest
}

update
