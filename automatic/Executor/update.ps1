$ErrorActionPreference = 'Stop'
import-module au

$base     = 'http://www.1space.dk/executor'
$releases = "$base/downloadlinks.html"

function global:au_BeforeUpdate {
  $Latest.Checksum32 = Get-RemoteChecksum $Latest.Url32
  Import-Module VirusTotalAnalyzer -NoClobber -Force
  New-VirusScan -ApiKey $env:VT_APIKEY -Url $Latest.URL32
	Start-Sleep -Seconds 60
	$vt = (Get-VirusScan -ApiKey $env:VT_APIKEY -Url $Latest.URL32).data.attributes.reputation
  if ( $vt -gt 5 ) {
	Write-Error "Ignoring $($Latest.PackageName) package due to virus total results - $vt positives"
	return 'ignore'
  }
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
	$downloadPage = Invoke-WebRequest -Uri $releases -UseBasicParsing
	$url32      = $downloadPage.links | where-object href -match 'E.+\.exe' | select-object -expand href | foreach-object { $base +  '/' + $_ } | Select-Object -First 1

	[XML]$feed	= $((Invoke-WebRequest -Uri 'http://www.1space.dk/executor/rssfeed.xml')).Content
	$version 	= $feed.rss.channel.item[0].title.split(' ')[-1].trim()

	return @{
		Url32 	= $url32
		Version = $version
	}
}

update -ChecksumFor 32 -NoCheckUrl -NoCheckChocoVersion
