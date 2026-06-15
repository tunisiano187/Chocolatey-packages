$ErrorActionPreference = 'Stop'
import-module chocolatey-AU
Import-Module ..\..\scripts\au_extensions.psm1

$releases = 'https://sourceforge.net/projects/pwgen-win/rss?path=/Password%20Tech'

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
	[xml]$xml = (Invoke-WebRequest -Uri $releases -UseBasicParsing).Content
	$item = $xml.rss.channel.item | Where-Object { $_.link -match '(?i)Setup\.exe/download' -and $_.link -notmatch '\.sig/' } | Select-Object -First 1
	$url32 = $item.link
	$version = [regex]::Match($url32, 'Password%20Tech/([^/]+)/').Groups[1].Value

	@{ URL32 = $url32; Version = $version }
}

update -ChecksumFor 32
