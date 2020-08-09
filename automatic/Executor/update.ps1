import-module au

# $releases = "http://www.1space.dk/executor/download.html"

function global:au_SearchReplace {
	@{
		'tools/chocolateyInstall.ps1' = @{
			"(^[$]url32\s*=\s*)('.*')"      = "`$1'$($Latest.URL32)'"
			"(^[$]checksum32\s*=\s*)('.*')" = "`$1'$($Latest.Checksum32)'"
			"(^[$]checksumType32\s*=\s*)('.*')" = "`$1'$($Latest.ChecksumType32)'"
		}
	}
}

function global:au_GetLatest {
	$url32 = 'http://www.1space.dk/executor/ExecutorSetup.exe'

	[XML]$feed = $((Invoke-WebRequest -Uri 'http://www.1space.dk/executor/rssfeed.xml')).Content
	$version = $feed.rss.channel.item[0].title.split(' ')[-1].trim()
	Write-Output "Version : $version"

	$Latest = @{ URL32 = $url32; Version = $version }
	return $Latest
}

update -ChecksumFor 32