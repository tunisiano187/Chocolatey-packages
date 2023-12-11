$ErrorActionPreference = 'Stop'
import-module au

$releases = 'https://www.dbvis.com/download'

function global:au_SearchReplace {
	@{
		'tools/chocolateyInstall.ps1' = @{
			"(^[$]url64\s*=\s*)('.*')"      = "`$1'$($Latest.URL64)'"
			"(^[$]checksum64\s*=\s*)('.*')" = "`$1'$($Latest.Checksum64)'"
			"(^[$]checksumType64\s*=\s*)('.*')" = "`$1'$($Latest.ChecksumType64)'"
		}
	}
}

function global:au_AfterUpdate($Package) {
	Invoke-VirusTotalScan $Package
}



function global:au_GetLatest {
	Write-Output 'Check Folder'
	$links = $(((Invoke-WebRequest -Uri $releases -UseBasicParsing).Links | Where-Object  {$_.href -match 'dbvis_windows'} | Where-Object  {$_.href -match 'exe'} | Where-Object {$_.href -notMatch '_jre'})).href | Select-Object -First 1

	if($links -notcontains "https") {
		$links = "https://www.dbvis.com$links"
	}
	$version = $links.split('-')[-1].replace('x64_','').replace('.exe','').replace('_','.')
	if($version -eq '23.2.5') {
		$version = '23.2.5.2023112601'
	}

	$url64 = $links

	$Latest = @{ URL64 = $url64; Version = $version }
	return $Latest
}

update -ChecksumFor 64 -NoCheckChocoVersion
