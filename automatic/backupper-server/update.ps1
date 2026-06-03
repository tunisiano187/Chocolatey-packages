import-module chocolatey-AU
Import-Module ..\..\scripts\au_extensions.psm1

# The ubackup.com website is behind Cloudflare and blocks automated requests.
# The direct download URL on aomeisoftware.com CDN is accessible without JS challenge.
$url32 = 'https://www2.aomeisoftware.com/download/adb/ABServerTrial.exe'

function global:au_SearchReplace {
	@{
    ".\tools\chocolateyInstall.ps1" = @{
            "(^[$]url(32)?\s*=\s*)('.*')"          = "`$1'$($Latest.URL32)'"
            "(^[$]checksum(32)?\s*=\s*)('.*')"     = "`$1'$($Latest.Checksum32)'"
            "(^[$]checksumType(32)?\s*=\s*)('.*')" = "`$1'$($Latest.ChecksumType32)'"
    }
	}
}

function global:au_BeforeUpdate {
	. ..\..\scripts\Get-FileVersion.ps1
	$FileVersion = Get-FileVersion $Latest.URL32
	$Latest.Checksum32 = $FileVersion.Checksum
	$Latest.ChecksumType32 = $FileVersion.ChecksumType
}

function global:au_AfterUpdate($Package) {
  Invoke-VirusTotalScan $Package
}

function global:au_GetLatest {
  # Download the exe and extract the version from PE FileVersionInfo.
  # This bypasses the Cloudflare challenge on ubackup.com/server.html which blocks
  # PowerShell Invoke-WebRequest. The permanent CDN URL always serves the latest installer.
  . ..\..\scripts\Get-FileVersion.ps1
  $FileVersion = Get-FileVersion $url32
  $version = $FileVersion.Version

  if (-not $version) { throw "Could not extract version from $url32" }

  return @{ URL32 = $url32; Version = $version }
}

update -ChecksumFor none -NoCheckChocoVersion
