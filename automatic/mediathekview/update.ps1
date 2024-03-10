Import-Module AU
import-module "$PSScriptRoot/../../scripts/au_extensions.psm1"

$releases = 'https://download.mediathekview.de/stabil/'

function global:au_BeforeUpdate($Package) {
  $licenseFile = "$PSScriptRoot\legal\LICENSE.txt"
  if (Test-Path $licenseFile) { Remove-Item -Force $licenseFile }

  Invoke-WebRequest -UseBasicParsing -Uri $($Package.nuspecXml.package.metadata.licenseUrl -replace 'blob', 'raw') -OutFile $licenseFile

  Get-RemoteFiles -Purge -NoSuffix
}
function global:au_AfterUpdate($Package) {
  Invoke-VirusTotalScan $Package
}

function global:au_SearchReplace {
  @{
    ".\legal\VERIFICATION.txt"      = @{
      "(?i)(^\s*location on\:?\s*)\<.*\>" = "`${1}<$releases>"
      "(?i)(\s*1\..+)\<.*\>"              = "`${1}<$($Latest.URL64)>"
      "(?i)(^\s*checksum\s*type\:).*"     = "`${1} $($Latest.ChecksumType64)"
      "(?i)(^\s*checksum(64)?\:).*"       = "`${1} $($Latest.Checksum64)"
    }
    ".\tools\chocolateyInstall.ps1" = @{
      "(?i)(^\s*file\s*=\s*`"[$]toolsPath\\).*" = "`${1}$($Latest.FileName64)`""
    }
  }
}

function global:au_GetLatest {
  $download_page = Invoke-WebRequest -Uri $releases -UseBasicParsing

  $re = 'MediathekView\-[\d\.]+.*\.zip$'
  $url64 = $download_page.Links | Where-Object href -match $re | Select-Object -last 1 -expand href | ForEach-Object {
    if (!$_.StartsWith("http")) {
      [uri]::new($releases, [string]$_)
    } else {
      $_
    }
  }

  $verRe = 'View-|-win(?:64)?\.zip'
  $version64 = $url64 -split "$verRe" | Select-Object -last 1 -skip 1
  @{
    URL64       = [uri]$url64
    Version     = [version]$version64
    PackageName = 'MediathekView'
  }
}

update -ChecksumFor none -NoCheckUrl
