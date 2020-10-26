$ErrorActionPreference = 'Stop'
import-module au

$releases = 'https://github.com/transmission/transmission/releases'

function global:au_SearchReplace {
	@{
		'tools/chocolateyInstall.ps1' = @{
			"(^[$]url\s*=\s*)('.*')"      = "`$1'$($Latest.URL32)'"
			"(^[$]checksum\s*=\s*)('.*')" = "`$1'$($Latest.Checksum32)'"
			"(^[$]checksumType\s*=\s*)('.*')" = "`$1'$($Latest.checksumType32)'"
			"(^[$]url64\s*=\s*)('.*')"      = "`$1'$($Latest.URL64)'"
			"(^[$]checksum64\s*=\s*)('.*')" = "`$1'$($Latest.Checksum64)'"
			"(^[$]checksumType64\s*=\s*)('.*')" = "`$1'$($Latest.checksumType64)'"
		}
	}
}

function global:au_GetLatest {
	$file = (((Invoke-WebRequest -Uri $releases -UseBasicParsing).Links | Where-Object {$_ -match '.msi'}).href | Where-Object {$_ -match '.msi'}) | Select-Object -First 2
	$url32 = "https://github.com$($file | Where-Object {$_ -match 'x86'})";
	$url64 = "https://github.com$($file | Where-Object {$_ -match 'x64'})";
	$version = $file.split('/')[-2].trim()

	$Latest = @{ URL32 = $url32; URL64 = $url64; Version = $version }
	return $Latest
}

update
