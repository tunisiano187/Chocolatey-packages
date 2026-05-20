import-module chocolatey-AU

$releases = 'https://api.github.com/repos/jitsi/jitsi-meet-electron/releases/latest'
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
  # Use -Latest to consistently get the newest non-draft non-pre-release
  $tags = Get-GitHubRelease -OwnerName $Owner -RepositoryName $repo -Latest

  if (-not $tags) {
    throw "Could not fetch GitHub releases for $Owner/$repo"
  }

	$url32 = $tags.assets.browser_download_url | Where-Object {$_ -match "\.exe$"} | Select-Object -First 1

  if (-not $url32) {
    throw "Could not find .exe asset in release"
  }

  # Strip leading 'v' and replace any remaining '-' separators with '.'
  $version = $tags.tag_name -replace '^v', ''

  if ($tags.prerelease -match "true") {
		$date = $tags.published_at.ToString("yyyyMMdd")
		$version = "$version-pre$($date)"
	}

  $releaseNotesUrl = $tags.html_url

  return @{
    URL32 = $url32
    Version = $version
    ReleaseNotes = $releaseNotesUrl
  }
}

update -ChecksumFor none
