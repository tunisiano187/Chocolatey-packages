$ErrorActionPreference = 'Stop'
import-module au

$releases = 'https://multibit.org/releases/multibit-classic/'

function global:au_SearchReplace {
	@{
		'tools/chocolateyInstall.ps1' = @{
			"(^[$]url\s*=\s*)('.*')"      		= "`$1'$($Latest.URL32)'"
			"(^[$]checksum\s*=\s*)('.*')" 		= "`$1'$($Latest.Checksum32)'"
            "(^[$]checksumtype\s*=\s*)('.*')" 	= "`$1'$($Latest.ChecksumType32)'"
            "(^[$]url64\s*=\s*)('.*')"      		= "`$1'$($Latest.URL64)'"
			"(^[$]checksum64\s*=\s*)('.*')" 		= "`$1'$($Latest.Checksum64)'"
			"(^[$]checksumType64\s*=\s*)('.*')" 	= "`$1'$($Latest.ChecksumType64)'"
		}
	}
}

function global:au_GetLatest {
	Write-Output 'Check Folder'
	$folder = "$releases$(((Invoke-WebRequest -Uri $releases -UseBasicParsing).Links | Where-Object {$_ -match "multibit"} | Select-Object -Last 1).href)"
	Write-Output 'Checking version'
	$installer = ((Invoke-WebRequest -Uri $folder -UseBasicParsing).Links | Where-Object {$_ -match ".exe"} | Where-Object {$_ -notmatch '.asc'} | Select-Object -First 2 | Sort-Object ).href
	$version=$($installer[0]).split('/')[-1].split('-')[-1].replace('.exe','')

	Write-Output "Version : $version"
	$url32 = "$($folder)$($installer[1])";
	$url64 = "$($folder)$($installer[0])";

	$Latest = @{ URL32 = $url32; URL64 = $url64; Version = $version }
	return $Latest
}

update
