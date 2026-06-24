$ErrorActionPreference = 'Stop'
import-module chocolatey-AU
Import-Module ..\..\scripts\au_extensions.psm1

$base     = 'https://executor.dk'
$releases = "$base/download"

function global:au_BeforeUpdate {
  $Latest.Checksum32 = Get-RemoteChecksum $Latest.Url32
}

function global:au_AfterUpdate($Package) {
	Invoke-VirusTotalScan $Package
}

function global:au_SearchReplace {
	@{
		'tools/chocolateyInstall.ps1' = @{
			"(Url\s*=\s*)('.*')"        = "`$1'$($Latest.Url32)'"
			"(Checksum\s*=\s*)('.*')" = "`$1'$($Latest.Checksum32)'"
			"(ChecksumType\s*=\s*)('.*')" = "`$1'$($Latest.ChecksumType32)'"
		}
	}
}

function global:au_GetLatest {
	$downloadPage = Invoke-WebRequest -Uri $releases -UseBasicParsing -UserAgent 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36'
	$url32 = $downloadPage.links | where-object { $_.href -match '^ExecutorSetup\.exe$' } | select-object -expand href | foreach-object { "$base/$_" } | Select-Object -First 1

	if (-not $url32) {
		throw "Could not find EXE download link"
	}

	$feedResponse = Invoke-WebRequest -Uri 'https://executor.dk/rssfeed.xml' -UseBasicParsing
	if (-not $feedResponse) {
		throw "Could not fetch RSS feed"
	}

	[XML]$feed = $feedResponse.Content
	if (-not $feed.rss.channel.item[0]) {
		throw "Could not parse RSS feed"
	}

	$version = $feed.rss.channel.item[0].title.split(' ')[-1].trim()

	return @{
		Url32 	= $url32
		Version = $version
	}
}

update -ChecksumFor 32 -NoCheckUrl -NoCheckChocoVersion
