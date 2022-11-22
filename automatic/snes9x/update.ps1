$ErrorActionPreference = 'Stop'
import-module au

$releases = 'http://www.s9x-w32.de/dl/?C=M;O=D'

function global:au_SearchReplace {
	@{
		'tools/chocolateyInstall.ps1' = @{
			"(^[$]url\s*=\s*)('.*')"      = "`$1'$($Latest.URL32)'"
			"(^[$]checksum\s*=\s*)('.*')" = "`$1'$($Latest.Checksum32)'"
			"(^[$]checksumType\s*=\s*)('.*')" = "`$1'$($Latest.ChecksumType32)'"
			"(^[$]url64\s*=\s*)('.*')"      = "`$1'$($Latest.URL64)'"
			"(^[$]checksum64\s*=\s*)('.*')" = "`$1'$($Latest.Checksum64)'"
			"(^[$]checksumType64\s*=\s*)('.*')" = "`$1'$($Latest.ChecksumType64)'"
		}
	}
}

function global:au_AfterUpdate($Package) {
	Invoke-VirusTotalScan $Package
}

function global:au_GetLatest {
	$installer = (((Invoke-WebRequest -Uri $releases -UseBasicParsing).Links | Where-Object {$_ -match 'snes9x-'} | Where-Object {$_ -match 'win32'} | Where-Object {$_ -match '.zip'} | Group-Object -Property href | select -First 2).Name)
	$version=$installer[0].split('-')[1]
	Write-Output "Version : $version"
	$url32 = "$("http://www.s9x-w32.de/dl/")$($installer[1])"
	$url64 = "$("http://www.s9x-w32.de/dl/")$($installer[0])"

	$Latest = @{ URL32 = $url32; URL64 = $url64; Version = $version }
	return $Latest
}

update
