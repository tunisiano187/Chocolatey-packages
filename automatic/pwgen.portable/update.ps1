$ErrorActionPreference = 'Stop'
import-module chocolatey-AU
Import-Module ..\..\scripts\au_extensions.psm1
. ..\..\scripts\Get-FileVersion.ps1

$releases = 'https://sourceforge.net/projects/pwgen-win/rss?path=/Password%20Tech'

function global:au_SearchReplace {
	@{
		'tools/chocolateyInstall.ps1' = @{
			"(^[$]url\s*=\s*)('.*')"      		= "`$1'$($Latest.URL32)'"
			"(^[$]checksum\s*=\s*)('.*')" 		= "`$1'$($Latest.Checksum32)'"
			"(^[$]checksumType\s*=\s*)('.*')" 	= "`$1'$($Latest.ChecksumType32)'"
			"(^[$]url64\s*=\s*)('.*')"      		= "`$1'$($Latest.URL64)'"
			"(^[$]checksum64\s*=\s*)('.*')" 		= "`$1'$($Latest.Checksum64)'"
			"(^[$]checksumType64\s*=\s*)('.*')" 	= "`$1'$($Latest.ChecksumType64)'"
		}
	}
}

function global:au_AfterUpdate($Package) {
	Invoke-VirusTotalScan $Package
}

function global:au_GetLatest {
	[xml]$xml = (Invoke-WebRequest -Uri $releases -UseBasicParsing).Content
	$item = $xml.rss.channel.item | Where-Object { $_.link -match 'portable\.zip/download' } | Select-Object -First 1
	$url = $item.link
	$version = [regex]::Match($url, 'Password%20Tech/([^/]+)/').Groups[1].Value

	$fileInfo = Get-FileVersion $url
	@{
		URL32          = $url
		URL64          = $url
		Version        = $version
		Checksum32     = $fileInfo.Checksum
		ChecksumType32 = $fileInfo.ChecksumType
		Checksum64     = $fileInfo.Checksum
		ChecksumType64 = $fileInfo.ChecksumType
	}
}

update -ChecksumFor none
