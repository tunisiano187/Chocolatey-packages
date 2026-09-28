$ErrorActionPreference = 'Stop'
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url64          = 'https://proton.me/download/pass/windows/ProtonPass_1.41.1.msix'
$checksum64     = '6D79822FC096DA7E819E915BADF1E92DB6FFA577D4E8615A6EA0A506D5ACABD4'
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
