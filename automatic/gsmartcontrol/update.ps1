$ErrorActionPreference = 'Stop'
import-module au

$releases = 'https://github.com/ashaduri/gsmartcontrol/releases/'

function global:au_SearchReplace {
	@{
		'tools/chocolateyInstall.ps1' = @{
			"(^[$]url32\s*=\s*)('.*')"      	= "`$1'$($Latest.URL32)'"
			"(^[$]checksum32\s*=\s*)('.*')" 	= "`$1'$($Latest.Checksum32)'"
			"(^[$]checksumType32\s*=\s*)('.*')" = "`$1'$($Latest.ChecksumType32)'"
			"(^[$]url64\s*=\s*)('.*')"      	= "`$1'$($Latest.URL64)'"
			"(^[$]checksum64\s*=\s*)('.*')" 	= "`$1'$($Latest.Checksum64)'"
			"(^[$]checksumType64\s*=\s*)('.*')" = "`$1'$($Latest.ChecksumType64)'"
		}
	}
}

function global:au_GetLatest {
	Write-Output 'Check Folder'
	$installer = (((Invoke-WebRequest -Uri $releases -UseBasicParsing).Links | Where-Object {$_ -match 'gsmartcontrol-'} | Where-Object {$_ -match ".exe"} | Where-Object {$_ -notmatch 'hotfix'} | Where-Object {$_ -notmatch 'sha256'}).href | Select-Object -First 2 | Sort-Object )
	Write-Output 'Checking version'
	$version=$installer[0].split('/')[-1].split('-')[1]
	Write-Output "Version : $version"
	$url32 = "https://github.com$($installer[0])";
	$url64 = "https://github.com$($installer[1])";

	$Latest = @{ URL32 = $url32; URL64 = $url64; Version = $version }
	return $Latest
}

update
