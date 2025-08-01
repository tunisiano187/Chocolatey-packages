$ErrorActionPreference = 'Stop'
import-module chocolatey-AU

function global:au_SearchReplace {
	@{
		"legal\VERIFICATION.txt"      = @{
			"(?i)(x86:).*"        				= "`${1} $($Latest.URL32)"
			"(?i)(checksum:).*" 				= "`${1} $($Latest.Checksum32)"
			"(?i)(checksumtype:).*" 			= "`${1} $($Latest.ChecksumType32)"
		}
	}
}

function global:au_BeforeUpdate {
	. ..\..\scripts\Get-FileVersion.ps1
	$FileVersion = Get-FileVersion $Latest.URL32 -keep
	Move-Item -Path $FileVersion.TempFile -Destination "tools\osfmount.exe"
	$Latest.Checksum32 = $FileVersion.Checksum
	$Latest.ChecksumType32 = $FileVersion.checksumType
}

function global:au_AfterUpdate($Package) {
	Invoke-VirusTotalScan $Package
}

function global:au_GetLatest {
	$releases='https://www.osforensics.com/tools/mount-disk-images.html'
	$page = Invoke-WebRequest -Uri $releases -UseBasicParsing
	$regexPattern = 'OSFMount V(\d+(\.\d+)*)'
	$versionMatch = $page.Content | Select-String -Pattern $regexPattern -AllMatches
	$version = $versionMatch.Matches[0].Groups[1].Value
	$url32 = "https://www.osforensics.com/downloads/osfmount.exe"

	$Latest = @{ URL32 = $url32; Version = $version }
	return $Latest
}

update -NoCheckUrl -ChecksumFor none
