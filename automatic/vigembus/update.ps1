import-module au

# $releases = 'https://github.com/ViGEm/ViGEmBus/releases/latest'
$Owner = "ViGEm"
$repo = "ViGEmBus"


function global:au_SearchReplace {
    @{
        "$($Latest.PackageName).nuspec" = @{
          "(\<releaseNotes\>).*?(\</releaseNotes\>)" = "`${1}$($Latest.ReleaseNotes)`$2"
        }

        ".\tools\VERIFICATION.txt" = @{
          "(?i)(\s+x32:).*"                   = "`${1} $($Latest.URL32)"
          "(?i)(Get-RemoteChecksum).*"        = "`${1} $($Latest.URL32)"
          "(?i)(\s+checksum32:).*"            = "`${1} $($Latest.Checksum32)"
        }
    }
}

function global:au_BeforeUpdate {
  Get-RemoteFiles -Purge -NoSuffix
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
  $tags = Get-GitHubRelease -OwnerName $Owner -RepositoryName $repo -Latest
  $regex = '\.exe$'
	$urls = $tags.assets.browser_download_url | Where-Object {$_ -match $regex}
  $url32 = $urls | Where-Object {$_ -match 'x86'}
	$version = ($url32 -split '/' | select-object -Last 1 -Skip 1).Replace('v','')
  if($tags.prerelease -match "true") {
    $date = $tags.published_at.ToString("yyyyMMdd")
    $version = "$version-pre$($date)"
  }
  Invoke-WebRequest -Uri "https://raw.githubusercontent.com/ViGEm/ViGEmBus/master/LICENSE" -OutFile ".\tools\LICENSE.txt"

  @{
      URL32 = $url32
      Version = $version
      ReleaseNotes = $tags.html_url
  }
}

update -ChecksumFor none
