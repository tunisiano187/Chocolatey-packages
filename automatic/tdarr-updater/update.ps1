$ErrorActionPreference = 'Stop'
import-module chocolatey-AU

$releases = 'https://docs.tdarr.io/docs/installation/windows-linux-macos'

function global:au_SearchReplace {
	@{
		"legal\VERIFICATION.txt"      = @{
			"(?i)(x86:).*"      		= "`${1} $($Latest.URL32)"
			"(?i)(checksum:).*" 		= "`${1} $($Latest.Checksum32)"
			"(?i)(checksum Type:).*" 	= "`${1} $($Latest.ChecksumType32)"
		}
	}
}

function global:au_BeforeUpdate {
	. ..\..\scripts\Get-FileVersion.ps1
	$FileVersion = Get-FileVersion $Latest.URL32 -keep
	Move-Item -Path $FileVersion.TempFile -Destination "tools\Tdarr_Updater.zip"
	$Latest.Checksum32 = $FileVersion.Checksum
	$Latest.ChecksumType32 = $FileVersion.checksumType
}

function global:au_AfterUpdate($Package) {
	. ..\..\scripts\Invoke-VirusTotalScan.ps1
	Invoke-VirusTotalScan $Package
}

function global:au_GetLatest {
	$url32 		= (((Invoke-WebRequest -Uri $releases -UseBasicParsing).Links | Where-Object {$_ -match 'win32_x64/Tdarr_Updater.zip'}).href)
	$version 	= Get-Version $url32


	$Latest = @{ URL32 = $url32; Version = $version }
	return $Latest
}

update -ChecksumFor none
