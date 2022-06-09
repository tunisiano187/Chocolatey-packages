$ErrorActionPreference = 'Stop'
import-module au

$releases = "https://www.wagnardsoft.com/forums/viewforum.php?f=5"

function global:au_SearchReplace {
	@{
		"tools\VERIFICATION.txt" = @{
			"(^Version\s+:).*"  	= "`${1} $($Latest.Version)"
			"(^URL\s+:).*"      	= "`${1} $($Latest.URL32)"
			"(^Checksum\s+:).*" 	= "`${1} $($Latest.Checksum32)"
			"(^ChecksumType\s+:).*" = "`${1} $($Latest.ChecksumType32)"
		}
	}
}

function global:au_GetLatest {
	Add-Type -AssemblyName System.Web # To URLDecode
	$links = ((Invoke-WebRequest -Uri $releases -UseBasicParsing).Links | Where-Object {$_ -match 'Released'}).href
	if ($links -is [array]) { $links = $links[0] }
	$urlend = $(([System.Web.HttpUtility]::UrlDecode($links).replace('./','').replace('&amp;','&')))
	$release="https://www.wagnardsoft.com/forums/$urlend"
	$splited=$release.split('&')
	$referer="$($splited[0])&$($splited[1])"
	$url32=(((Invoke-WebRequest -Uri $release -UseBasicParsing).Links | Where-Object {$_ -match '.exe'}).href)

	#$version=$url32.split('/')[-1].ToLower().split('v')[-1].replace('.exe','')
	$version = Get-Version $url32

	$Latest = @{ URL32 = $url32; Referer = $referer; Version = $version }
	return $Latest
}

function global:au_BeforeUpdate() {
	Write-Output "Downloading $($Latest.Version) installer file"
	Get-RemoteFiles -Purge -NoSuffix
}


update -ChecksumFor 32 -NoCheckChocoVersion
