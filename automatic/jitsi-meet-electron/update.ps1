import-module chocolatey-AU

$Owner = 'jitsi'
$repo = 'jitsi-meet-electron'

function global:au_SearchReplace {
  @{
    ".\tools\chocolateyInstall.ps1" = @{
      "(?i)(^\s*url\s*=\s*)('.*')"            = "`$1'$($Latest.URL32)'"
      "(?i)(^\s*checksum\s*=\s*)('.*')"       = "`$1'$($Latest.Checksum32)'"
      "(?i)(^\s*checksumType\s*=\s*)('.*')"   = "`$1'$($Latest.ChecksumType32)'"
    }
    ".\jitsi-meet-electron.nuspec" = @{
      "\<releaseNotes\>.+" = "<releaseNotes>$($Latest.ReleaseNotes)</releaseNotes>"
    }
  }
}

function global:au_BeforeUpdate {
	. ..\..\scripts\Get-FileVersion.ps1
	$FileVersion = Get-FileVersion $Latest.URL32
	$Latest.Checksum32 = $FileVersion.Checksum
	$Latest.ChecksumType32 = $FileVersion.checksumType
}

function global:au_AfterUpdate($Package) {
	. ..\..\scripts\Invoke-VirusTotalScan.ps1
	Invoke-VirusTotalScan $Package
}

function global:au_GetLatest {
  # Use direct REST call instead of Get-GitHubRelease to avoid rate-limit failures in CI
  $headers = @{ 'User-Agent' = 'chocolatey-au-updater/1.0' }
  $release = Invoke-RestMethod "https://api.github.com/repos/$Owner/$repo/releases/latest" -Headers $headers

  if (-not $release) {
    throw "Could not fetch GitHub releases for $Owner/$repo"
  }

  $url32 = $release.assets.browser_download_url | Where-Object { $_ -match '\.exe$' } | Select-Object -First 1

  if (-not $url32) {
    throw "Could not find .exe asset in release"
  }

  # Strip leading 'v'
  $version = $release.tag_name -replace '^v', ''

  if ($release.prerelease) {
    $date = $release.published_at.ToString("yyyyMMdd")
    $version = "$version-pre$($date)"
  }

  return @{
    URL32        = $url32
    Version      = $version
    ReleaseNotes = $release.html_url
  }
}

update -ChecksumFor none
