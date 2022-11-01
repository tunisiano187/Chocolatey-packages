$ErrorActionPreference = 'Stop'
import-module au

$releases = "https://github.com/dogecoin/dogecoin/releases/latest"
$Owner = $releases.Split('/') | Select-Object -Last 1 -Skip 3
$repo = $releases.Split('/') | Select-Object -Last 1 -Skip 2

function global:au_SearchReplace {
    @{
        'tools\chocolateyInstall.ps1' = @{
            "(^[$]url\s*=\s*)('.*')"            = "`$1'$($Latest.URL32)'"
            "(^[$]checksum\s*=\s*)('.*')"       = "`$1'$($Latest.Checksum32)'"
            "(^[$]checksumType\s*=\s*)('.*')"   = "`$1'$($Latest.ChecksumType32)'"
            "(^[$]url64\s*=\s*)('.*')"            = "`$1'$($Latest.URL64)'"
            "(^[$]checksum64\s*=\s*)('.*')"       = "`$1'$($Latest.Checksum64)'"
            "(^[$]checksumType64\s*=\s*)('.*')"   = "`$1'$($Latest.ChecksumType64)'"
        }
     }
}

function global:au_BeforeUpdate {
	Import-Module VirusTotalAnalyzer -NoClobber -Force
	New-VirusScan -ApiKey $env:VT_APIKEY -Url $Latest.URL32
	New-VirusScan -ApiKey $env:VT_APIKEY -Url $Latest.URL64
	Start-Sleep -Seconds 60
	$vt = (Get-VirusScan -ApiKey $env:VT_APIKEY -Url $Latest.URL32).data.attributes.reputation
	if ( $vt -gt 5 ) {
	  Write-Error "Ignoring $($Latest.PackageName) package due to virus total results - $vt positives"
	  return 'ignore'
	}
	$vt = (Get-VirusScan -ApiKey $env:VT_APIKEY -Url $Latest.URL64).data.attributes.reputation
	if ( $vt -gt 5 ) {
	  Write-Error "Ignoring $($Latest.PackageName) package due to virus total results - $vt positives"
	  return 'ignore'
	}
}

function global:au_GetLatest {
    $tags = Get-GitHubRelease -OwnerName $Owner -RepositoryName $repo -Latest
    $urls = $tags.assets.browser_download_url | Where-Object {$_ -match "-setup-"} | Where-Object {$_ -match ".exe$"}
    $url32 = $urls | Where-Object {$_ -match 'win32'}
	$url64 = $urls | Where-Object {$_ -match 'win64'}
	$version = $url32 -split 'v|/' | select-object -Last 1 -Skip 1

	$Latest = @{ URL32 = $url32; URL64 = $url64; Version = $version }
    return $Latest
}

update
