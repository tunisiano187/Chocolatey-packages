import-module au

$releases = 'https://github.com/Ryochan7/DS4Windows/releases/latest'
$Owner = $releases.Split('/') | Select-Object -Last 1 -Skip 3
$repo = $releases.Split('/') | Select-Object -Last 1 -Skip 2

function global:au_SearchReplace {
    @{
        "$($Latest.PackageName).nuspec" = @{
          "(\<releaseNotes\>).*?(\</releaseNotes\>)" = "`${1}$($Latest.ReleaseNotes)`$2"
        }

        ".\tools\VERIFICATION.txt" = @{
          "(?i)(\s+x64:).*"                   = "`${1} $($Latest.URL64)"
          "(?i)(Get-RemoteChecksum).*"        = "`${1} $($Latest.URL64)"
          "(?i)(\s+checksum64:).*"            = "`${1} $($Latest.Checksum64)"
        }
    }
}

function global:au_BeforeUpdate {
  Get-RemoteFiles -Purge -NoSuffix
  $file = (Get-ChildItem -Path .\tools -Exclude *.txt,*.ps1 | Select-Object -First 1).FullName
  if($file.count -gt 0) {
    Import-Module VirusTotalAnalyzer -NoClobber -Force
    New-VirusScan -ApiKey $env:VT_APIKEY -File $file
	  Start-Sleep -Seconds 60
	  $vt = (Get-VirusScan -ApiKey $env:VT_APIKEY -File $file).data.attributes.reputation
    if ( $vt -gt 5 ) {
          Write-Error "Ignoring $($Latest.PackageName) package due to virus total results - $vt positives"
          return 'ignore'
    }
  }
}


function global:au_GetLatest {
  $tags = Get-GitHubRelease -OwnerName $Owner -RepositoryName $repo -Latest
  $urls = $tags.assets.browser_download_url | Where-Object {$_ -match ".zip$"}
  $url = $urls | Where-Object {$_ -match 'x64'}
  $version = $tags.tag_name.Replace('v','')
  if($tags.prerelease -match "true") {
      $date = $tags.published_at.ToString("yyyyMMdd")
      $version = "$version-pre$($date)"
  }
  @{
    URL64 = $url
    Version = $version.Replace('v','')
    ReleaseNotes = "https://github.com/Ryochan7/DS4Windows/releases/tag/${version}"
  }
}

update -ChecksumFor none
