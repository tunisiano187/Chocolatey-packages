import-module chocolatey-AU

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
}

function global:au_AfterUpdate($Package) {
	Import-Module ..\..\scripts\au_extensions.psm1
	Invoke-VirusTotalScan $Package
}


function global:au_GetLatest {
  try {
    $tags = Get-GitHubRelease -OwnerName $Owner -RepositoryName $repo -Latest

    if (-not $tags) {
      throw "Could not fetch GitHub releases for $Owner/$repo"
    }

    $urls = $tags.assets.browser_download_url | Where-Object {$_ -match ".zip$"}
    if (-not $urls) {
      throw "No zip assets found in release"
    }

    $url = $urls | Where-Object {$_ -match 'x64'} | Select-Object -First 1
    if (-not $url) {
      throw "No x64 zip found in assets"
    }

    $version = $tags.tag_name.Replace('v','')
    if($tags.prerelease -match "true") {
        $date = $tags.published_at.ToString("yyyyMMdd")
        $version = "$version-pre$($date)"
    }

    return @{
      URL64 = $url
      Version = $version.Replace('v','')
      ReleaseNotes = "https://github.com/Ryochan7/DS4Windows/releases/tag/${version}"
    }
  }
  catch {
    Write-Error "Error getting latest DS4Windows version: $_"
    throw
  }
}

update -ChecksumFor none -NoCheckChocoVersion
