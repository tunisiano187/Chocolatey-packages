import-module au

$releases = 'https://boinc.berkeley.edu/dl/'

function global:au_SearchReplace {
	@{
		'tools/chocolateyInstall.ps1' = @{
			"(^[$]url\s*=\s*)('.*')"      = "`$1'$($Latest.URL32)'"
			"(^[$]checksum\s*=\s*)('.*')" = "`$1'$($Latest.Checksum32)'"
		}
	}
}

function global:au_GetLatest {
	$installer = (((Invoke-WebRequest -Uri $releases -UseBasicParsing).Links | Where-Object {$_ -match 'windows'} | Where-Object {$_ -match 'windows_x86_64.exe'} | Where-Object {$_ -match 'boinc_'}).href)[-1]
	$version = Get-Version $installer
	Write-Output "Version : $version"
	$url32 = "$($releases)$($installer)"

	$Latest = @{ URL32 = $url32; Version = $version }
	return $Latest
}

update -ChecksumFor 32