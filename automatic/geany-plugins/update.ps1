$ErrorActionPreference = 'Stop'
import-module au

$releases = 'https://plugins.geany.org/geany-plugins/'

function global:au_SearchReplace {
	@{
		'tools/chocolateyInstall.ps1' = @{
			"(^[$]url\s*=\s*)('.*')"      = "`$1'$($Latest.URL32)'"
			"(^[$]checksum\s*=\s*)('.*')" = "`$1'$($Latest.Checksum32)'"
			"(^[$]checksumType\s*=\s*)('.*')" = "`$1'$($Latest.ChecksumType32)'"
		}
	}
}

function global:au_GetLatest {
	$url32 = ((Invoke-WebRequest -Uri $releases -UseBasicParsing).Links | Where-Object {$_ -match 'setup.exe'} | Where-Object {$_ -notmatch 'exe.sig'}).href[-1]
	$version = $url32.split('_')[0].split('-')[-1]
	$url32 = "https://plugins.geany.org/geany-plugins/$($url32)"

	$Latest = @{ URL32 = $url32; Version = $version }
	return $Latest
}

update -ChecksumFor 32
