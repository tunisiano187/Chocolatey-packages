$ErrorActionPreference = 'Stop'
$ErrorView             = 'NormalView'

Import-Module -Global -Name Chocolatey-AU
Import-Module -Force -Global `
  -FullyQualifiedName '..\..\scripts\Update-Metadata.ps1'

$ghReleases    = 'https://api.github.com/repos/kvirc/KVIrc/releases/latest'
$ghRelRegex    = 'KVIrc-(?<ghver>[\d\.]+)-\w+-x86_64.exe$'
$nightlyURL    = 'https://nightly.kvirc.net/win-x86_64/'
$nightlyRegex  = 'KVIrc-(?<betaver>[\d\.]+-dev-[\d-]{10})-git-[a-f0-9]{7}.exe$'

function global:au_SearchReplace {
  @{
    'tools\chocolateyInstall.ps1' = @{
      "(^[$]url64\s*=\s*)('.*')"        = "`$1'$($Latest.URL64)'"
      "(^[$]checksum64\s*=\s*)('.*')"   = "`$1'$($Latest.Checksum64)'"
      "(^[$]checksumType\s*=\s*)('.*')" = "`$1'$($Latest.ChecksumType64)'"
    }
  }
}

function global:au_AfterUpdate($Package) {
  Invoke-VirusTotalScan $Package
}

function global:au_BeforeUpdate {
  Get-RemoteFiles -Purge
  $Latest.Checksum64     = Get-RemoteChecksum $Latest.URL64
  $Latest.ChecksumType64 = $Latest.ChecksumType
}

function global:au_GetLatest {
  $ghTags           = (Invoke-WebRequest -Uri $ghReleases | ConvertFrom-Json)
  $ghReleaseURL     = $ghTags.assets.browser_download_url |
    Where-Object { $_ -match $ghRelRegex } | Select-Object -First 1
  $ghReleaseVersion = $Matches.ghver

  Update-Metadata -NuspecFile '.\kvirc.nuspec' -key releaseNotes `
    -value $ghTags.html_url

  $nightlyRelease        = (
    Invoke-WebRequest -Uri $nightlyURL -UseBasicParsing
  ).Links.href | Where-Object {
    $_ -match $nightlyRegex
  } | Select-Object -Last 1
  $nightlyReleaseURL     = "https://nightly.kvirc.net${nightlyRelease}"
  $nightlyReleaseVersion = $Matches.betaver

  if($nightlyReleaseVersion -ge $ghReleaseVersion) {
    $Latest = @{
      ChecksumType = 'sha512'
      URL64        = $nightlyReleaseURL
      Version      = $nightlyReleaseVersion
    }
  } else {
    $Latest = @{
      ChecksumType = 'sha512'
      URL64        = $ghReleaseURL
      Version      = $ghReleaseVersion
    }
  }

  return $Latest
}

Update-Package -ChecksumFor none
