$ErrorActionPreference = 'Stop'
import-module au

function global:au_SearchReplace {
	@{
		'tools/chocolateyInstall.ps1' = @{
			"(^[$]url\s*=\s*)('.*')"      = "`$1'$($Latest.URL32)'"
			"(^[$]checksum\s*=\s*)('.*')" = "`$1'$($Latest.Checksum32)'"
			"(^[$]checksumType\s*=\s*)('.*')" = "`$1'$($Latest.ChecksumType32)'"
		}
	}
}

function global:au_AfterUpdate($Package) {
	Invoke-VirusTotalScan $Package
}

function global:au_GetLatest {
	$url32 = "https://netstatagent.com/files/netagent-setup.exe"
	. ..\..\scripts\Get-FileVersion.ps1
	$FileVersion = Get-FileVersion $url32
	
	$Latest = @{ URL32 = $url32; Checksum32 = $FileVersion.Checksum; ChecksumType32 = $FileVersion.ChecksumType; Version = $FileVersion.Version }
	return $Latest
}

update -ChecksumFor none