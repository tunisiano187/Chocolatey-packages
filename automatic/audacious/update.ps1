$ErrorActionPreference = 'Stop'
import-module au

$releases = 'https://distfiles.audacious-media-player.org/'

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
	$url32 = ((Invoke-WebRequest -Uri $releases -UseBasicParsing).Links | Where-Object  {$_.href -match '-win32.exe'})[-1].href
	$version = $url32.split('-')[1].trim()
	if ($url32 -like '*beta*') {
		$version += "-$($url32.split('-')[2].trim())"
	}
	$url32 = "$($releases)$($url32)"

	$Latest = @{ URL32 = $url32; Version = $version }
	return $Latest
}

update -ChecksumFor 32
