$ErrorActionPreference = 'Stop'
import-module au

$releases = 'https://github.com/lhmouse/nano-win/tags'

function global:au_SearchReplace {
	@{
		'tools/chocolateyInstall.ps1' = @{
			"(^[$]url\s*=\s*)('.*')"      			= "`$1'$($Latest.URL32)'"
			"(^[$]checksum\s*=\s*)('.*')" 			= "`$1'$($Latest.Checksum32)'"
            "(^[$]checksumtype\s*=\s*)('.*')" 		= "`$1'$($Latest.ChecksumType32)'"
		}
	}
}

function global:au_GetLatest {
	Write-Verbose 'Get files'
	$url32 = ((Invoke-WebRequest -Uri $releases -UseBasicParsing).Links | Where-Object {$_ -match '.zip'} | Select-Object -First 1).href
	Write-Verbose 'Checking version'
	$version=$($url32).split('v')[-1].replace('.zip','')

	Write-Verbose "Version : $version"
	$url32 = "https://github.com$($url32)";

	$Latest = @{ URL32 = $url32; Version = $version }
	return $Latest
}

update -ChecksumFor 32 -NoCheckChocoVersion