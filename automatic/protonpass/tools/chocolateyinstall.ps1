$ErrorActionPreference = 'Stop'
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url64          = 'https://proton.me/download/pass/windows/ProtonPass_1.43.0.msix'
$checksum64     = '461695C552DA38B43EAE8D6F7D7F141B7F1A58095B324AE8104FA3B0056E5390'
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
