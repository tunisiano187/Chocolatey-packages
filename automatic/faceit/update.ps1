$ErrorActionPreference = 'Stop'
import-module au
. ..\..\scripts\Get-FileVersion.ps1

$release = 'https://faceit-client.faceit-cdn.net/release/FACEIT-setup-latest.exe'

function global:au_SearchReplace {
	@{
		'tools/chocolateyInstall.ps1' = @{
			"(^[$]url\s*=\s*)('.*')"      		= "`$1'$($Latest.URL32)'"
			"(^[$]checksum\s*=\s*)('.*')" 		= "`$1'$($Latest.Checksum32)'"
			"(^[$]checksumType\s*=\s*)('.*')" 	= "`$1'$($Latest.ChecksumType32)'"
		}
	}
}

function global:au_AfterUpdate($Package) {
	Invoke-VirusTotalScan $Package
}

function global:au_GetLatest {
	$Fileinfos = Get-FileVersion -url $release

	$Latest = @{ URL32 = $release; Checksum32 = $Fileinfos.Checksum; ChecksumType32 = $Fileinfos.ChecksumType; Version = $Fileinfos.Version }
	return $Latest
}

update -ChecksumFor none -NoCheckChocoVersion
