import-module au

$releases = 'https://johnsad.ventures/software/backgroundswitcher/windows/'

function global:au_SearchReplace {
	@{
		'tools/chocolateyInstall.ps1' = @{
			"(^[$]url\s*=\s*)('.*')"      = "`$1'$($Latest.URL32)'"
			"(^[$]checksum\s*=\s*)('.*')" = "`$1'$($Latest.Checksum32)'"
		}
	}
}

function global:au_GetLatest {
	$jbs = (Invoke-WebRequest -Uri $releases)
	$url32 = (($jbs.Links | Where-Object {$_ -match 'exe'})[0].href
	$version = ($jbs.Links | Where-Object {$_.innerHTML -match 'Version'})[0].innerHTML.split(' ')[1]
	
	$Latest = @{ URL32 = $url32; Version = $version }
	return $Latest
}

update -ChecksumFor 32