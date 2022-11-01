$ErrorActionPreference = 'Stop'
import-module au

$releases = "https://github.com/duplicati/duplicati/releases/latest"
$Owner = $releases.Split('/') | Select-Object -Last 1 -Skip 3
$repo = $releases.Split('/') | Select-Object -Last 1 -Skip 2

function global:au_SearchReplace {
    @{
        'tools\chocolateyInstall.ps1' = @{
            "(^[$]url\s*=\s*)('.*')"            = "`$1'$($Latest.URL32)'"
            "(^[$]checksum\s*=\s*)('.*')"       = "`$1'$($Latest.Checksum32)'"
            "(^[$]checksumType\s*=\s*)('.*')"   = "`$1'$($Latest.ChecksumType32)'"
        }
     }
}

function global:au_BeforeUpdate {
	Import-Module VirusTotalAnalyzer -NoClobber -Force
	New-VirusScan -ApiKey $env:VT_APIKEY -Url $Latest.URL32
	Start-Sleep -Seconds 60
	$vt = (Get-VirusScan -ApiKey $env:VT_APIKEY -Url $Latest.URL32).data.attributes.reputation
	if ( $vt -gt 5 ) {
	  Write-Error "Ignoring $($Latest.PackageName) package due to virus total results - $vt positives"
	  return 'ignore'
	}
}

function global:au_GetLatest {
    $tags = Get-GitHubRelease -OwnerName $Owner -RepositoryName $repo | Select-Object -First 1
	$urls = $tags.assets.browser_download_url | Where-Object {$_ -match ".zip$"}
    $url32 = $urls | Where-Object {$_ -notmatch 'signatures'}
    $version = ($tags.tag_name).split('v|-')[1]
    if($tags.prerelease -match "true") {
        $date = $tags.published_at.ToString("yyyyMMdd")
        $version = "$version-pre$($date)"
    }

	$Latest = @{ URL32 = $url32; Version = $version }
    return $Latest
}

update -ChecksumFor 32
