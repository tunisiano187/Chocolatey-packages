$ErrorActionPreference = 'Stop'
import-module au

$releases = "https://benchmarks.ul.com/downloads/pcmark8.zip"

function global:au_BeforeUpdate {
	. ..\..\scripts\Get-FileVersion.ps1
	$FileVersion = Get-FileVersion $Latest.URL32
	$Latest.Checksum32 = $FileVersion.Checksum
	$Latest.ChecksumType32 = $FileVersion.checksumType
}

function global:au_AfterUpdate($Package) {
	Invoke-VirusTotalScan $Package
}

function global:au_SearchReplace {
	@{
		'tools/chocolateyInstall.ps1' = @{
			"(^[$]url\s*=\s*)('.*')"      		= "`$1'$($Latest.URL32)'"
			"(^[$]checksum\s*=\s*)('.*')" 		= "`$1'$($Latest.Checksum32)'"
			"(^[$]checksumType\s*=\s*)('.*')" 	= "`$1'$($Latest.ChecksumType32)'"
		}
	}
}

function global:au_GetLatest {
	$url=Get-RedirectedUrl $releases
	$version = (Get-Version $url.Replace('-','.')).Version
	if($version -eq '2.10.901') {
		$version = '2.10.901.2024091301'
	}

	$Latest = @{ URL32 = $url; Version = $version}

    return $Latest
}

update -ChecksumFor 32
