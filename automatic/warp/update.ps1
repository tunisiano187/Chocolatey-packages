$ErrorActionPreference = 'Stop'
import-module au

$releases = "https://api.appcenter.ms/v0.1/public/sparkle/apps/50ab4048-8c3c-4084-ab64-793a4993a6b3"

function global:au_SearchReplace {
	@{
		'tools/chocolateyInstall.ps1' = @{
			"(^[$]url64\s*=\s*)('.*')"      		= "`$1'$($Latest.URL64)'"
			"(^[$]checksum64\s*=\s*)('.*')" 		= "`$1'$($Latest.Checksum64)'"
			"(^[$]checksumType64\s*=\s*)('.*')" 	= "`$1'$($Latest.ChecksumType64)'"
		}
	}
}

function global:au_GetLatest {
	[XML]$page = Invoke-WebRequest -Uri $releases
	$url64=$page.rss.channel.Item[0].enclosure.url

    $version = $page.rss.channel.Item[0].enclosure.version

	$Latest = @{ URL64 = $url64; Version = $version}

    return $Latest
}

update -ChecksumFor none -NoCheckChocoVersion