$ErrorActionPreference = 'Stop'
import-module AU
Import-Module ..\..\scripts\au_extensions.psm1

function global:au_SearchReplace {
	@{
		"legal\VERIFICATION.txt"      = @{
			"(?i)(x86:).*"        				= "`${1} $($Latest.URL32)"
			"(?i)(checksum:).*" 				= "`${1} $($Latest.Checksum32)"
		}
	}
}

function global:au_AfterUpdate($Package) {
	Invoke-VirusTotalScan $Package
}

function global:au_GetLatest {
	$url32 = "https://www.nirsoft.net/utils/mzcacheview.zip"
	Invoke-WebRequest -Uri $url32 -OutFile "tools/mzcacheview.zip"
	$checksum32 = Get-FileHash -Path "tools/mzcacheview.zip" -Algorithm $env:ChocolateyChecksumType
	$pageContent = Invoke-WebRequest -Uri "https://www.nirsoft.net/utils/mozilla_cache_viewer.html"
	$regexPattern = 'MZCacheView v(\d+(\.\d+)*)'
	$versionMatch = $pageContent.Content | Select-String -Pattern $regexPattern -AllMatches
	$version = $versionMatch.Matches[0].Groups[1].Value
	Update-Metadata -key "copyright" -value "© $(Get-Date -Format "yyyy") NirSoft"

	$Latest = @{ URL32 = $url32; Checksum32 = $checksum32; ChecksumType32 = $env:ChocolateyChecksumType; Version = $version }
	return $Latest
}

update -ChecksumFor none -NoCheckChocoVersion
