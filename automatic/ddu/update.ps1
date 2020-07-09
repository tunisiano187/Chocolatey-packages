import-module au

$releases = "https://www.wagnardsoft.com/forums/viewforum.php?f=5"

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
	Add-Type -AssemblyName System.Web # To URLDecode
	$release="https://www.wagnardsoft.com/forums/$([System.Web.HttpUtility]::UrlDecode(((Invoke-WebRequest -Uri $releases -UseBasicParsing).Links | Where-Object {$_ -match 'Released'}).href[0].replace('./','').replace('&amp;','&')))"
	$splited=$release.split('&')
	$referer="$($splited[0])&$($splited[1])"
	$url32=((Invoke-WebRequest -Uri $release -UseBasicParsing).Links | Where-Object {$_ -match '.exe'}).href

	$version=$url32.split('/')[-1].ToLower().split('v')[-1].replace('.exe','')

	$Latest = @{ URL32 = $url32; Referer = $referer; Version = $version }
	return $Latest
}

update -ChecksumFor 32