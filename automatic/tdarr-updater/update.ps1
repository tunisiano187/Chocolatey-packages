$ErrorActionPreference = 'Stop'
import-module Chocolatey-AU

$releases = 'https://docs.tdarr.io/docs/installation/windows-linux-macos'

function global:au_SearchReplace {
	@{
		'tools/chocolateyInstall.ps1' = @{
			"(url\s*=\s*)'.*'"          = "`$1'$($Latest.URL32)'"
			"(checksum\s*=\s*)'.*'"     = "`$1'$($Latest.Checksum32)'"
			"(checksumType\s*=\s*)'.*'" = "`$1'$($Latest.ChecksumType32)'"
		}
		"legal\VERIFICATION.txt" = @{
			"(?i)(x86:).*"           = "`${1} $($Latest.URL32)"
			"(?i)(checksum:).*"      = "`${1} $($Latest.Checksum32)"
			"(?i)(checksum Type:).*" = "`${1} $($Latest.ChecksumType32)"
		}
	}
}

function global:au_AfterUpdate($Package) {
	. ..\..\scripts\Invoke-VirusTotalScan.ps1
	Invoke-VirusTotalScan $Package
}

function global:au_GetLatest {
	$url32   = (((Invoke-WebRequest -Uri $releases -UseBasicParsing).Links | Where-Object {$_ -match 'win32_x64/Tdarr_Updater.zip'}).href)
	$version = Get-Version $url32

	. ..\..\scripts\Get-FileVersion.ps1
	$FileVersion = Get-FileVersion $url32

	return @{ URL32 = $url32; Version = $version; Checksum32 = $FileVersion.Checksum; ChecksumType32 = $FileVersion.ChecksumType }
}

update -ChecksumFor none
