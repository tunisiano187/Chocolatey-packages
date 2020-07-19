import-module au

$referer = "http://www.nirsoft.net/utils/chromepass.html"
$url32 = 'http://www.nirsoft.net/toolsdownload/chromepass.zip'

function global:au_SearchReplace {
	@{
		'tools/chocolateyInstall.ps1' = @{
			"(^[$]url\s*=\s*)('.*')"      = "`$1'$($Latest.URL32)'"
			"(^[$]checksum\s*=\s*)('.*')" = "`$1'$($Latest.Checksum32)'"
			"(^[$]checksumType\s*=\s*)('.*')" = "`$1'$($Latest.ChecksumType32)'"
			"(^[$]referer\s*=\s*)('.*')" = "`$1'$($Latest.Referer)'"
		}
	}
}

function global:au_GetLatest {
	$version = Get-Version $url32

	$Latest = @{ URL32 = $url32; Referer = $referer; Version = $version }
	return $Latest
}

update -ChecksumFor 32