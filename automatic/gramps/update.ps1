$ErrorActionPreference = 'Stop'
import-module au

$releases = 'https://api.github.com/repos/gramps-project/gramps/releases/latest'

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
	$tags = Invoke-WebRequest $releases -UseBasicParsing | ConvertFrom-Json
	$installer = ($tags[0].assets | where {$_.browser_download_url -match ".exe$"}).browser_download_url | Sort-Object -Descending
	$url32 = $installer | Where-Object {$_ -match 'win32'} | Select-Object -First 1
	$url64 = $installer | Where-Object {$_ -match 'win64'} | Select-Object -First 1
	Write-Output 'Checking version'
	$version=$($installer[0]).split('O')[-1].split('_')[0].trim().substring(1).replace('-','.')

	Write-Output "Version : $version"
	
	if($version -eq '5.1.3.2') {
		$version = '5.1.3.3'
	}

	$Latest = @{ URL32 = $url32; URL64 = $url64; Version = $version }
	return $Latest
}

update -NoCheckChocoVersion