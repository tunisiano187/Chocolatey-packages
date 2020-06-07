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
	$installer = (((Invoke-WebRequest -Uri $releases -UseBasicParsing).Links | Where-Object {$_ -match 'gridcoin-'} | Where-Object {$_ -match "-setup.exe"} | Where-Object {$_ -notmatch 'hotfix'} | Where-Object {$_ -notmatch 'sha256'}).href | Select -First 2 | Sort-Object)
	$version=$installer.split('-')[1]
	Write-host "Version : $version"
	$url32 = "$($releases)$($installer)"
	
	$Latest = @{ URL32 = $url32; Version = $version }
	return $Latest
}

update -ChecksumFor 32