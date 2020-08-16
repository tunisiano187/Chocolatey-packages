$ErrorActionPreference = 'Stop'
import-module au

$releases = 'https://github.com/aria2/aria2/releases'

function global:au_SearchReplace {
	@{
		'tools/chocolateyInstall.ps1' = @{
			"(^[$]url\s*=\s*)('.*')"      			= "`$1'$($Latest.URL32)'"
			"(^[$]checksum\s*=\s*)('.*')" 			= "`$1'$($Latest.Checksum32)'"
            "(^[$]checksumtype\s*=\s*)('.*')" 		= "`$1'$($Latest.ChecksumType32)'"
            "(^[$]url64\s*=\s*)('.*')"      		= "`$1'$($Latest.URL64)'"
			"(^[$]checksum64\s*=\s*)('.*')" 		= "`$1'$($Latest.Checksum64)'"
			"(^[$]checksumType64\s*=\s*)('.*')" 	= "`$1'$($Latest.ChecksumType64)'"
		}
	}
}

function global:au_GetLatest {
	Write-Verbose 'Get files'
	$installer = ((Invoke-WebRequest -Uri $releases -UseBasicParsing).Links | Where-Object {$_ -match "-win-"} | Where-Object {$_ -match '.zip'} | Select-Object -First 2 | Sort-Object ).href
	Write-Verbose 'Checking version'
	$version=$($installer[0]).split('/')[-1].split('-')[1]

	Write-Verbose "Version : $version"
	$url32 = "https://github.com/$($installer[1])";
	$url64 = "https://github.com/$($installer[0])";

	$Latest = @{ URL32 = $url32; URL64 = $url64; Version = $version }
	return $Latest
}

update
