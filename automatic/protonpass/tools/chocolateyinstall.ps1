$ErrorActionPreference = 'Stop'
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url64          = 'https://proton.me/download/pass/windows/ProtonPass_1.44.1.msix'
$checksum64     = '186B5984E51CF3866561B61D4C87FC10AAFD55C711E33E891B1A66CEB3A17C2D'
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
