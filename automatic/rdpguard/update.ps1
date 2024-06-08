$ErrorActionPreference = 'Stop'
import-module au

$releases = 'https://rdpguard.com/download.aspx'

function global:au_SearchReplace {
	@{
		'tools/chocolateyInstall.ps1' = @{
			"(^[$]url\s*=\s*)('.*')"      = "`$1'$($Latest.URL32)'"
			"(^[$]checksum\s*=\s*)('.*')" = "`$1'$($Latest.Checksum32)'"
			"(^[$]checksumType\s*=\s*)('.*')" = "`$1'$($Latest.ChecksumType32)'"
		}
	}
}

function global:au_AfterUpdate($Package) {
	Invoke-VirusTotalScan $Package
}

function global:au_GetLatest {
	$page = Invoke-WebRequest -Uri $releases -UseBasicParsing
	$url32 = $page.Links.href | Where-Object { $_ -match ".exe$" } | Select-Object -First 1
	$version = $url32.Split('/|.')[-2].trim('rdpguard-').replace('-','.')

	$Latest = @{ URL32 = $url32; Version = $version }
	return $Latest
}

update -ChecksumFor 32
