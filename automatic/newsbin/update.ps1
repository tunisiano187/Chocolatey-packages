$ErrorActionPreference = 'Stop'
import-module au

$releases = 'https://www.newsbin.com/freetrial.php'

function global:au_SearchReplace {
	@{
		'tools/chocolateyInstall.ps1' = @{
			"(^[$]url\s*=\s*)('.*')"      		= "`$1'$($Latest.URL32)'"
			"(^[$]checksum\s*=\s*)('.*')" 		= "`$1'$($Latest.Checksum32)'"
			"(^[$]checksumType\s*=\s*)('.*')" 	= "`$1'$($Latest.ChecksumType32)'"
		}
	}
}

function global:au_AfterUpdate($Package) {
	Invoke-VirusTotalScan $Package
}

function global:au_GetLatest {
	$releasepage = ((Invoke-WebRequest -Uri $releases).Links | Where-Object {$_.href -match "download.php?"} | Select-Object -First 1).href
	$version=get-version $releasepage
	$url32 = $releasepage.Replace('&amp;','&')
	
	$Latest = @{ URL32 = $url32; Version = $version}
	return $Latest
}

update -ChecksumFor 32
