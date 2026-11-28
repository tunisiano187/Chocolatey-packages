$ErrorActionPreference = 'Stop'
import-module chocolatey-AU

function global:au_SearchReplace {
	@{
		"legal\VERIFICATION.txt"      = @{
			"(?i)(x86:).*"        				= "`${1} $($Latest.URL32)"
			"(?i)(checksum:).*" 				= "`${1} $($Latest.Checksum32)"
		}
	}
}

function global:au_BeforeUpdate {
	. ..\..\scripts\Get-FileVersion.ps1
	$FileVersion = Get-FileVersion $Latest.URL32 -keep
	# Get-FileVersion derives .FileName via Chocolatey's own Get-WebFileName, which can append an
	# extra extension (e.g. ".txt") based on the server's Content-Type response at download time
	# instead of trusting the URL's own ".zip". chocolateyInstall.ps1 always looks for an exact
	# "mzcacheview.zip", so a renamed drop here silently breaks 7z extraction on install.
	#
	# A first attempt at this fix (just retargeting Move-Item's destination, PR #4495) did NOT
	# actually clear it: v2.25.0 failed chocolatey.org's verification testing a second time with
	# the identical mzcacheview.zip.txt, on a build confirmed (via git ancestry) to have run with
	# that fix already in place. The remaining suspect is au_AfterUpdate: Invoke-VirusTotalScan
	# calls AU's own Get-RemoteFiles -NoSuffix whenever neither $Latest.FileName32 nor FileName64
	# is already set, which independently re-downloads $Latest.URL32 into tools\ *after* this
	# function runs - a second, redundant write to the same destination. Force the move (in case a
	# stale same-named file is already present), verify it actually landed, and set FileName32
	# ourselves so that redundant second download is skipped entirely.
	Move-Item -Path $FileVersion.TempFile -Destination "tools\mzcacheview.zip" -Force
	if (-not (Test-Path "tools\mzcacheview.zip")) {
		throw "tools\mzcacheview.zip is missing after Move-Item - chocolateyInstall.ps1 would fail to find it"
	}
	$Latest.Checksum32 = $FileVersion.Checksum
	$Latest.ChecksumType32 = $FileVersion.checksumType
	$Latest.FileName32 = 'mzcacheview.zip'
}

function global:au_AfterUpdate($Package) {
	. ..\..\scripts\Invoke-VirusTotalScan.ps1
	Invoke-VirusTotalScan $Package
}

function global:au_GetLatest {
	$url32 = "https://www.nirsoft.net/utils/mzcacheview.zip"
	$pageContent = Invoke-WebRequest -Uri "https://www.nirsoft.net/utils/mozilla_cache_viewer.html"
	$regexPattern = 'MZCacheView v(\d+(\.\d+)*)'
	$versionMatch = $pageContent.Content | Select-String -Pattern $regexPattern -AllMatches
	$version = $versionMatch.Matches[0].Groups[1].Value
	Update-Metadata -key "copyright" -value "(c) $(Get-Date -Format "yyyy") NirSoft"

	$Latest = @{ URL32 = $url32; Version = $version }
	return $Latest
}

update -ChecksumFor none
