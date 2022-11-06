import-module au

$version_url = 'https://www.sweetscape.com/010editor/latest_version.html'

# todo: add executable to "App Path" registry

function global:au_SearchReplace {
  @{
    ".\tools\chocolateyInstall.ps1" = @{
      "(^[$]url32\s*=\s*)('.*')"          = "`$1'$($Latest.URL32)'"
      "(^[$]url64\s*=\s*)('.*')"          = "`$1'$($Latest.URL64)'"
      "(^[$]checksum32\s*=\s*)('.*')"     = "`$1'$($Latest.Checksum32)'"
      "(^[$]checksum64\s*=\s*)('.*')"     = "`$1'$($Latest.Checksum64)'"
      "(^[$]checksumType32\s*=\s*)('.*')"     = "`$1'$($Latest.ChecksumType32)'"
      "(^[$]checksumType64\s*=\s*)('.*')"     = "`$1'$($Latest.ChecksumType64)'"
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
  New-VirusScan -ApiKey $env:VT_APIKEY -Url $Latest.URL64
	Start-Sleep -Seconds 60
	$vt = (Get-VirusScan -ApiKey $env:VT_APIKEY -Url $Latest.URL64).data.attributes.reputation
  if ( $vt -gt 5 ) {
        Write-Error "Ignoring $($Latest.PackageName) package due to virus total results - $vt positives"
        return 'ignore'
  }
}

function global:au_GetLatest {
  $url      = "https://www.sweetscape.com/download/010EditorWin32Portable.zip"
  $url64    = "https://www.sweetscape.com/download/010EditorWin64Portable.zip"

  $download_version = Invoke-WebRequest -Uri $version_url
  $version_text = $($download_version.ParsedHtml.getElementsByTagName("h2") | Select-Object -First 1 | ForEach-Object innerText)
  $version_text -match "Version (.*) - .*$"
  $version = $Matches[1]

  return @{
    URL32 = $url
    URL64 = $url64
    Version = $version
  }
}

update -NoCheckChocoVersion