import-module au
. $PSScriptRoot\..\_scripts\all.ps1

$domain   = 'https://www.sweetscape.com/'
$version_url = 'https://www.sweetscape.com/010editor/latest_version.html'
$releases   = 'https://www.sweetscape.com/download/010editor/download_010editor_win32_portable.html'
$releases64 = 'https://www.sweetscape.com/download/010editor/download_010editor_win64_portable.html'

# todo: add executable to "App Path" registry

function global:au_SearchReplace {
  @{
    ".\tools\chocolateyInstall.ps1" = @{
      "(^[$]url32\s*=\s*)('.*')"      = "`$1'$($Latest.URL32)'"
      "(^[$]url64\s*=\s*)('.*')"      = "`$1'$($Latest.URL64)'"
      "(^[$]checksum32\s*=\s*)('.*')"      = "`$1'$($Latest.Checksum32)'"
      "(^[$]checksum64\s*=\s*)('.*')"      = "`$1'$($Latest.Checksum64)'"
    }
  }
}

function global:au_GetLatest {
  $download_page = Invoke-WebRequest -UseBasicParsing -Uri $releases
  $download_page64 = Invoke-WebRequest -UseBasicParsing -Uri $releases64

  $re    = '\.exe$'
  $url   = ($download_page.links | ? href -match $re | select -First 1 -expand href).Replace("../","")
  $url64   = ($download_page64.links | ? href -match $re | select -First 1 -expand href).Replace("../","")

  $download_version = Invoke-WebRequest -Uri $version_url
  $version_text = $($download_version.ParsedHtml.getElementsByTagName("h2") | select -First 1 | % innerText)
  $version_text -match "Version (.*) - .*$"
  $version = $Matches[1]

  return @{
    URL32 = $domain + $url
    URL64 = $domain + $url64
    Version = $version
  }
}

update -ChecksumFor all
