$ErrorActionPreference = 'Stop'
import-module au

$releases = 'https://litecoin.org/'

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
	$page = Invoke-WebRequest -Uri $releases
	$url32 = ($page.links | Where-Object { $_.href -match 'exe$'}).href | Select-Object -First 1
	Update-Metadata -key "releaseNotes" -value $tags.html_url
	$version=$url32.Split('-') | Where-Object {$_ -Match '\.'} | Where-Object {$_ -notmatch ".exe$"} | Where-Object {$_ -notmatch '\/'}

	$Latest = @{ URL32 = $url32; Version = $version }
	return $Latest
}

update -ChecksumFor 32