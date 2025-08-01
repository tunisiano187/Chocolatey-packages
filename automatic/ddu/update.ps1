$ErrorActionPreference = 'Stop'
import-module chocolatey-AU

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

function global:au_AfterUpdate($Package) {
	Invoke-VirusTotalScan $Package
}

function global:au_GetLatest {
	Add-Type -AssemblyName System.Web # To URLDecode
	$links = ((Invoke-WebRequest -Uri $releases -UseBasicParsing).Links | Where-Object {$_ -match 'Released'}).href
	if ($links -is [array]) { $links = $links[0] }
	$urlend = $(([System.Web.HttpUtility]::UrlDecode($links).replace('./','').replace('&amp;','&')))
	$release="https://www.wagnardsoft.com/forums/$urlend"
	$splited=$release.split('&')
	$referer="$($splited[0])&$($splited[1])"
	$url32=(((Invoke-WebRequest -Uri $release -UseBasicParsing).Links | Where-Object {$_ -match '.exe'} | Where-Object {$_ -notmatch 'setup'}).href)

	$version=$url32.split('/')[-1].ToLower().split('v')[-1].replace('.exe','')
	#$version = Get-Version $url32
	if($version -eq "18.0.7.7") {
		$version = '18.0.7.2024062101'
	}
	$version = $version.Replace('_setup','')

	$Latest = @{ URL32 = $url32; Referer = $referer; Version = $version }
	return $Latest
}


update -ChecksumFor 32
