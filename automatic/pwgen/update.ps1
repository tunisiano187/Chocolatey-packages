$ErrorActionPreference = 'Stop'
import-module chocolatey-AU

$releases = 'https://sourceforge.net/projects/pwgen-win/rss?path=/Password%20Tech'

function global:au_SearchReplace {
	@{
		 "$($Latest.PackageName).nuspec" = @{
			 "(\<dependency .+?`"$($Latest.PackageName).install`" version=)`"([^`"]+)`"" = "`$1`"[$($Latest.Version)]`""
		 }
	 }
 }

function global:au_GetLatest {
	[xml]$xml = (Invoke-WebRequest -Uri $releases -UseBasicParsing).Content
	$item = $xml.rss.channel.item | Where-Object { $_.link -match '(?i)Setup\.exe/download' -and $_.link -notmatch '\.sig/' } | Select-Object -First 1
	if ($null -eq $item) { throw "Could not find Setup.exe in SourceForge RSS feed for Password Tech" }
	$version = [regex]::Match($item.link, 'Password%20Tech/([^/]+)/').Groups[1].Value

	@{ Version = $version }
}

update -ChecksumFor none -NoCheckUrl
