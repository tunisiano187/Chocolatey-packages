$ErrorActionPreference = 'Stop'

import-module au
$releases = 'https://api.github.com/repos/zhongyang219/TrafficMonitor/releases/latest'
$Owner = $releases.Split('/') | Select-Object -Last 1 -Skip 3
$repo = $releases.Split('/') | Select-Object -Last 1 -Skip 2

function global:au_SearchReplace {
	@{
		"tools\VERIFICATION.txt" = @{
			"(32-Bit\s+:).*"  			= "`${1} $($Latest.URL32)"
			"(checksum32\s+:).*" 		= "`${1} $($Latest.Checksum32)"
			"(checksum_type\s+:).*" 	= "`${1} $($Latest.ChecksumType32)"
			"(64-Bit\s+:).*"      		= "`${1} $($Latest.URL64)"
			"(checksum64\s+:).*" 		= "`${1} $($Latest.Checksum64)"
		}
		"tools\chocolateyinstall.ps1" = @{
			"(^[$]url32\s*=\s*)('.*')"      	= "`$1'$($Latest.URL32)'"
			"(^[$]checksum32\s*=\s*)('.*')" 	= "`$1'$($Latest.Checksum32)'"
			"(^[$]checksumType32\s*=\s*)('.*')"	= "`$1'$($Latest.checksumType32)'"
			"(^[$]url64\s*=\s*)('.*')"      	= "`$1'$($Latest.URL64)'"
			"(^[$]checksum64\s*=\s*)('.*')" 	= "`$1'$($Latest.Checksum64)'"
			"(^[$]checksumType64\s*=\s*)('.*')" = "`$1'$($Latest.checksumType64)'"
		}
	}
}

function global:au_BeforeUpdate {
	Get-RemoteFiles -Purge -NoSuffix
	Import-Module VirusTotalAnalyzer -NoClobber -Force
	$tempfile32 = $(New-TemporaryFile).Fullname.Replace('.tmp','.exe')
	$tempfile64 = $(New-TemporaryFile).Fullname.Replace('.tmp','.exe')
	Invoke-WebRequest -Uri $Latest.URL32 -OutFile $tempfile32
	Invoke-WebRequest -Uri $Latest.URL64 -OutFile $tempfile64
	New-VirusScan -ApiKey $env:VT_APIKEY -File $tempfile32
	New-VirusScan -ApiKey $env:VT_APIKEY -File $tempfile64

	Start-Sleep -Seconds 60
	$vt = (Get-VirusScan -ApiKey $env:VT_APIKEY -File $tempfile32).data.attributes.reputation
	if ( $vt -gt 5 ) {
	  Write-Error "Ignoring $($Latest.PackageName) package due to virus total results - $vt positives"
	  return 'ignore'
	}
	$vt = (Get-VirusScan -ApiKey $env:VT_APIKEY -File $tempfile64).data.attributes.reputation
	if ( $vt -gt 5 ) {
	  Write-Error "Ignoring $($Latest.PackageName) package due to virus total results - $vt positives"
	  return 'ignore'
	}
}

function global:au_GetLatest {
	$tags = Get-GitHubRelease -OwnerName $Owner -RepositoryName $repo -Latest
	$urls = $tags.assets.browser_download_url
    $url32 = $urls | Where-Object {$_ -match 'x86.zip'}
    $url64 = $urls | Where-Object {$_ -match 'x64.zip'}
	$version = $tags.tag_name.Tolower().replace('v','')
    if($tags.tag_name -match $version) {
        if($tags.prerelease -match "true") {
            $date = $tags.published_at.ToString("yyyyMMdd")
            $version = "$version-pre$($date)"
        }
    }
	Invoke-WebRequest -Uri "https://raw.githubusercontent.com/zhongyang219/TrafficMonitor/master/LICENSE" -OutFile ".\tools\LICENSE.txt"

	$Latest = @{ URL32 = $url32; URL64 = $url64; Version = $version }
	return $Latest
}

 update
