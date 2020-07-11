import-module au

$releases = 'https://github.com/hxseven/Remove-Empty-Directories/releases'

function global:au_SearchReplace {
	@{
		'tools/chocolateyInstall.ps1' = @{
			"(^[$]url\s*=\s*)('.*')"      = "`$1'$($Latest.URL32)'"
			"(^[$]checksum\s*=\s*)('.*')" = "`$1'$($Latest.Checksum32)'"
			"(^[$]checksumType\s*=\s*)('.*')" = "`$1'$($Latest.checksumType32)'"
		}
	}
}

function global:au_GetLatest {
	$file = (((Invoke-WebRequest -Uri $releases -UseBasicParsing).Links | Where-Object {$_ -match '.zip'}).href | Where-Object {$_ -match '.zip'})[0]
	$url32 = "https://github.com$($file)";
	$version = $file.split('/')[-1].replace('.zip','')

	$Latest = @{ URL32 = $url32; Version = $version }
	return $Latest
}

update -ChecksumFor 32 -NoCheckChocoVersion