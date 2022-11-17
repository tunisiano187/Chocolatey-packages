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

function global:au_AfterUpdate($Package) {
	Invoke-VirusTotalScan $Package
}
}


function global:au_GetLatest {
    $download_page = Invoke-WebRequest -UseBasicParsing -Uri $releases
    $download_page64 = Invoke-WebRequest -UseBasicParsing -Uri $releases64

    $re    = '\.exe$'
    $url   = ($download_page.links | Where-Object href -match $re | Select-Object -First 1 -expand href).Replace("../","")
    $url64   = ($download_page64.links | Where-Object href -match $re | Select-Object -First 1 -expand href).Replace("../","")

    $tempfile = New-TemporaryFile
    Invoke-WebRequest -Uri $version_url -UseBasicParsing -OutFile $tempfile
    $version = $(Get-Content $tempfile | Where-Object {$_ -match 'h1'}).split(' ')[-1].split('<')[0]

    return @{
        URL32 = $domain + $url
        URL64 = $domain + $url64
        Version = $version
    }
}

if ($MyInvocation.InvocationName -ne '.') { # run the update only if script is not sourced
  update
}