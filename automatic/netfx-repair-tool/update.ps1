$ErrorActionPreference = 'Stop'
import-module chocolatey-AU

$release = 'https://aka.ms/DotnetRepairTool'

function global:au_SearchReplace {
	@{
		'tools/chocolateyInstall.ps1' = @{
			"(^[$]url(32)?\s*=\s*)('.*')"      		= "`$1'$($Latest.URL32)'"
			"(^[$]checksum(32)?\s*=\s*)('.*')" 		= "`$1'$($Latest.Checksum32)'"
			"(^[$]checksumType(32)?\s*=\s*)('.*')" 	= "`$1'$($Latest.ChecksumType32)'"
		}
	}
}

function global:au_AfterUpdate($Package) {
	Invoke-VirusTotalScan $Package
}

function global:au_GetLatest {
	$url32 = Get-RedirectedUrl $release
	. ..\..\scripts\Get-FileVersion.ps1
	$FileInfo = Get-FileVersion $url32

	$Latest = @{ URL32 = $url32; Version = $FileInfo.Version; Checksum32 = $FileInfo.CHECKSUM; ChecksumType32 = $FileInfo.ChecksumType }
	return $Latest
}

update -ChecksumFor none
