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
	# "mzcacheview.zip", so a renamed drop here silently breaks 7z extraction on install (confirmed:
	# v2.25.0 shipped with mzcacheview.zip.txt and failed chocolatey.org's verification testing with
	# "7-Zip encountered a fatal error... The system cannot find the file specified"). Target the
	# exact filename chocolateyInstall.ps1 expects instead of trusting the dynamically detected name.
	Move-Item -Path $FileVersion.TempFile -Destination "tools\mzcacheview.zip"
	$Latest.Checksum32 = $FileVersion.Checksum
	$Latest.ChecksumType32 = $FileVersion.checksumType
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
