$ErrorActionPreference = 'Stop'
import-module au

$release = 'https://www.filejuggler.com/download/filejuggler.exe'

function global:au_SearchReplace {
	@{
		'tools/chocolateyInstall.ps1' = @{
			"(^[$]url\s*=\s*)('.*')"      		= "`$1'$($Latest.URL32)'"
			"(^[$]checksum\s*=\s*)('.*')" 		= "`$1'$($Latest.Checksum32)'"
			"(^[$]checksumtype\s*=\s*)('.*')" 	= "`$1'$($Latest.ChecksumType32)'"
		}
	}
}

function global:au_AfterUpdate($Package) {
	Invoke-VirusTotalScan $Package
}

function global:au_GetLatest {
	choco update -y autohotkey
	. ..\..\Scripts\Get-FileVersion.ps1
	$FileInfos = Get-FileVersion -url $release
	$Latest = @{ URL32 = $release; Checksum32 = $FileInfos.Checksum32; ChecksumType32 = $FileInfos.ChecksumType32; Version = $FileInfos.Version }
	return $Latest
}

update -ChecksumFor none
