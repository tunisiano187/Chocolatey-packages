$ErrorActionPreference = 'Stop'
import-module au

$releases = 'https://boinc.berkeley.edu/download.php'

function global:au_SearchReplace {
	@{
		'tools/chocolateyInstall.ps1' = @{
			"(^[$]url\s*=\s*)('.*')"      = "`$1'$($Latest.URL32)'"
			"(^[$]checksum\s*=\s*)('.*')" = "`$1'$($Latest.Checksum32)'"
		}
	}
}

function global:au_GetLatest {
	$installer = (((Invoke-WebRequest -Uri $releases -UserAgent "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/64.0.3282.167 Safari/537.36" -UseBasicParsing).Links | Where-Object {$_ -match 'windows_x86_64.exe'} | Where-Object {$_ -match 'boinc_'}).href)
	$version = Get-Version $installer
	if($version -match '7.16.16') {
		$version = '7.16.16.20201101'
	}
	Write-Output "Version : $version"
	$url32 = "$($installer)"

	$Latest = @{ URL32 = $url32; Version = $version }
	return $Latest
}

update -ChecksumFor 32 -NoCheckChocoVersion
