$ErrorActionPreference = 'Stop'
import-module au

$releases = 'https://static.idriveonlinebackup.com/downloads/version_win.js'

function global:au_SearchReplace {
	@{
		'tools/chocolateyInstall.ps1' = @{
			"(^[$]url\s*=\s*)('.*')"      = "`$1'$($Latest.URL32)'"
			"(^[$]checksum\s*=\s*)('.*')" = "`$1'$($Latest.Checksum32)'"
		}
	}
}

function global:au_AfterUpdate($Package) {
	Invoke-VirusTotalScan $Package
}

function global:au_GetLatest {
	$url32 = (Invoke-WebRequest -Uri $releases -UseBasicParsing).content.split("'") | Where-Object {$_ -match 'exe'} | Select-Object -First 1

	$version = ((Invoke-WebRequest -Uri $releases -UseBasicParsing).content.split('"') | Where-Object {$_ -match 'Version '} | Select-Object -First 1).split(' ') | Select-Object -Last 1

	$Latest = @{ URL32 = $url32; Version = $version.trim() }
	return $Latest
}

update -ChecksumFor 32
