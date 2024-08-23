$ErrorActionPreference = 'Stop'
import-module au

$release = 'https://www.microsoft.com/en-us/download/details.aspx?id=30135'

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
	$page = Invoke-WebRequest -Uri $release
	$url32 = $page.Links.href | Where-Object {$_ -match ".exe$"} | Select-Object -First 1
	. ..\..\scripts\Get-FileVersion.ps1
	$FileInfo = Get-FileVersion $url32

	$Latest = @{ URL32 = $url32; Version = $FileInfo.Version; Checksum32 = $FileInfo.CHECKSUM; ChecksumType32 = $FileInfo.ChecksumType }
	return $Latest
}

update -ChecksumFor none