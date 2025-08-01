$ErrorActionPreference = 'Stop'
import-module chocolatey-AU

$url32 = 'https://download.silicondust.com/hdhomerun/hdhomerun_windows.exe'

function global:au_AfterUpdate($Package) {
	Invoke-VirusTotalScan $Package
}

function global:au_SearchReplace {
	@{
		'tools/chocolateyInstall.ps1' = @{
			"(^[$]url\s*=\s*)('.*')"      = "`$1'$($Latest.URL32)'"
			"(^[$]checksum\s*=\s*)('.*')" = "`$1'$($Latest.Checksum32)'"
			"(^[$]checksumType\s*=\s*)('.*')" = "`$1'$($Latest.ChecksumType32)'"
		}
	}
}

function global:au_GetLatest {
	. ..\..\scripts\Get-FileVersion.ps1
	$FileVersion = Get-FileVersion $url32

	$Latest = @{ URL32 = $url32; Version = $FileVersion.Version; Checksum32 = $FileVersion.Checksum; ChecksumType32 = $FileVersion.ChecksumType }
	return $Latest
}

update -ChecksumFor none
