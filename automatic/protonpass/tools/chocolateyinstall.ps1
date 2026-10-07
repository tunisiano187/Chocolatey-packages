$ErrorActionPreference = 'Stop'
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url64          = 'https://proton.me/download/pass/windows/ProtonPass_1.42.0.msix'
$checksum64     = 'B8E707D530E57D2DE7E8F990E20EA3BED228B41EE4DF99EE3EAF0CA674F53773'
$checksumType64 = 'sha256'

if ((Get-IsWinServer)) {
  Write-Warning "  ** This package is for Windows Workstation OSes only. Aborting."
  throw
}

$dlArgs = @{
  PackageName    = $env:ChocolateyPackageName
  FileFullPath   = Join-Path $toolsDir 'ProtonPass.msix'
  Url64bit       = $url64
  Checksum64     = $checksum64
  ChecksumType64 = $checksumType64
}

Get-ChocolateyWebFile @dlArgs
Add-AppxPackage -Path $dlArgs.FileFullPath
