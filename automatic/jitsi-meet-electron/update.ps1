import-module chocolatey-AU

$domain   = 'https://github.com'
$ghproj = 'jitsi/jitsi-meet-electron'
$releases = "$domain/$ghproj/releases/latest"

$Owner = $releases.Split('/') | Select-Object -Last 1 -Skip 3
$repo = $releases.Split('/') | Select-Object -Last 1 -Skip 2

function global:au_SearchReplace {
  @{
    ".\tools\chocolateyInstall.ps1" = @{
      "(?i)(^\s*checksum\s*=\s*)('.*')"   = "`$1'$($Latest.Checksum32)'"
      "(?i)(^\s*checksumType\s*=\s*)('.*')" = "`$1'$($Latest.ChecksumType32)'"
      "(?i)(^\s*checksum64\s*=\s*)('.*')"   = "`$1'$($Latest.Checksum64)'"
      "(?i)(^\s*checksumType64\s*=\s*)('.*')" = "`$1'$($Latest.ChecksumType64)'"
    }
    ".\jitsi-meet-electron.nuspec" = @{
      "\<releaseNotes\>.+" = "<releaseNotes>$($Latest.ReleaseNotes)</releaseNotes>"
    }
    ".\tools\VERIFICATION.txt" = @{
      "(?i)(URL:).*"             = "`${1} $($Latest.URL32)"
      "(?i)(checksum type:).*"   = "`${1} $($Latest.ChecksumType32)"
      "(?i)(checksum32:).*"      = "`${1} $($Latest.Checksum32)"
      "(?i)(checksum64:).*"      = "`${1} $($Latest.Checksum64)"
    }
  }
}


function global:au_BeforeUpdate {
  set-alias 7z $Env:chocolateyInstall\tools\7z.exe

  $toolsp="$PSScriptRoot\tools"
  $downtemp="$PSScriptRoot\temp"
  Remove-Item "$downtemp" -Recurse -Force -ea ignore
  mkdir "$downtemp"
  $downf = "$downtemp\jitsi.exe"
  #$ProgressPreference = 'SilentlyContinue'
  Invoke-WebRequest $Latest.URL32 -OutFile  $downf
  7z x $downf "-o$downtemp"

  Remove-Item "$toolsp\*.7z"
  Move-Item "$downtemp\`$PLUGINSDIR\*.7z" $toolsp
  Remove-Item "$downtemp" -Recurse -Force -ea ignore

  #Based on Get-RemoteFiles

  $f32="app-32.7z"
  $f64="app-64.7z"
  $Algorithm = 'sha256'

  $global:Latest.Checksum32 = Get-FileHash "$toolsp\$f32" -Algorithm $Algorithm | ForEach-Object Hash
  $global:Latest.ChecksumType32 = $Algorithm
  $global:Latest.FileName32 = $f32

  $global:Latest.Checksum64 = Get-FileHash "$toolsp\$f64" -Algorithm $Algorithm | ForEach-Object Hash
  $global:Latest.ChecksumType64 = $Algorithm
  $global:Latest.FileName64 = $f32

  Invoke-WebRequest https://raw.githubusercontent.com/jitsi/jitsi-meet-electron/master/LICENSE -OutFile "$toolsp\LICENSE"
  7z e "$toolsp\$f32" "-o$toolsp" "LICENSE*"

}


function global:au_GetLatest {
  $tags = Get-GitHubRelease -OwnerName $Owner -RepositoryName $repo -Latest
  $url = $tags.assets.browser_download_url | Where-Object {$_ -match ".exe$"}
  $version = $tags.tag_name.Replace('v','')
  Update-Metadata -key "releaseNotes" -value $tags.html_url
	if($tags.prerelease -match "true") {
      $date = $tags.published_at.ToString("yyyyMMdd")
      $version = "$version-pre$($date)"
  }

  $releaseNotesUrl = $tags.html_url

  @{
    URL32 = $url
    Version = $version
    ReleaseNotes = $releaseNotesUrl
  }
}

update -ChecksumFor none
