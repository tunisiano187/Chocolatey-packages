$ErrorActionPreference = 'Stop'
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url64          = 'https://proton.me/download/pass/windows/ProtonPass_1.44.0.msix'
$checksum64     = '91BCFBA6348A8F46B2916D299D4B9A0B56AF8721791727AC0A4312BE3F3A6BA8'
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
