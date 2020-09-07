$ErrorActionPreference = 'Stop'
import-module au

$releases = 'http://www.h2database.com/html/main.html'

function global:au_SearchReplace {
	@{
		'tools/chocolateyInstall.ps1' = @{
			"(^[$]url\s*=\s*)('.*')"      	= "`$1'$($Latest.URL32)'"
			"(^[$]checksum\s*=\s*)('.*')" 	= "`$1'$($Latest.Checksum32)'"
			"(^[$]checksumType\s*=\s*)('.*')" = "`$1'$($Latest.ChecksumType32)'"
		}
	}
}

function global:au_GetLatest {
	Write-Output 'Check Folder'
	$url32 = (((Invoke-WebRequest -Uri $releases -UseBasicParsing).Links | Where-Object {$_ -match '.exe'}).href | Select-Object -First 1)

	Write-Output 'Checking version'
	$rssversion = 'https://h2database.com/html/newsfeed-rss.xml'
	[xml]$result=(Invoke-WebRequest -Uri $rssversion -UseBasicParsing).Content
	$version=$result.rss.channel.item[0].title.split(':|(')[1].trim()
	Write-Output "Version : $version"

	return @{ URL32 = $url32; Version = $version }
}

update -ChecksumFor 32