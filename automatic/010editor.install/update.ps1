import-module au

$domain   = 'https://www.sweetscape.com/'
$version_url = 'https://www.sweetscape.com/010editor/latest_version.html'
$releases   = 'https://www.sweetscape.com/download/010editor/download_010editor_win32.html'
$releases64 = 'https://www.sweetscape.com/download/010editor/download_010editor_win64.html'

if ($MyInvocation.InvocationName -ne '.') { # run the update only if the script is not sourced
    function global:au_SearchReplace {
      @{
        "tools\chocolateyInstall.ps1" = @{
          "(^[$]url32\s*=\s*)('.*')"            = "`$1'$($Latest.URL32)'"
          "(^[$]url64\s*=\s*)('.*')"            = "`$1'$($Latest.URL64)'"
          "(^[$]checksum32\s*=\s*)('.*')"       = "`$1'$($Latest.Checksum32)'"
          "(^[$]checksum64\s*=\s*)('.*')"       = "`$1'$($Latest.Checksum64)'"
        }
      }
    }
}

function Get-fileinfo($url) {
  $result = Invoke-WebRequest -method GET -Uri $url
  $outFilename = $result.Headers."Content-Disposition".split('=')[-1]
  return $outFilename
}

function global:au_GetLatest {
    $download_page = Invoke-WebRequest -UseBasicParsing -Uri $releases
    $download_page64 = Invoke-WebRequest -UseBasicParsing -Uri $releases64

    $re    = '\.exe$'
    $url   = ($download_page.links | ? href -match $re | select -First 1 -expand href).Replace("../","")
    $url64   = ($download_page64.links | ? href -match $re | select -First 1 -expand href).Replace("../","")

    $filename = Get-fileinfo($domain + $url)
    $version = $filename.split('r')[-1].replace('.exe','')

    return @{
        URL32 = $domain + $url
        URL64 = $domain + $url64
        Version = $version
    }
}

if ($MyInvocation.InvocationName -ne '.') { # run the update only if script is not sourced
  update
}