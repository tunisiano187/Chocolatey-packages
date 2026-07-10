$ErrorActionPreference = 'Stop'
$packageName    = 'solarwinds-backup-manager'
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url            = 'https://cdn.cloudbackup.management/maxdownloads/mxb-windows-x86_x64.exe'
$checksum       = '9BB5E7A4AE1B0FA42B7C495CD9124C81BD2CED2D614D49DAEF6C95A3D9BFF201'
$checksumType   = 'sha256'

Write-Host "  ** Backup Manager will open its web console in your default browser after installing." -ForeGround Magenta

$packageArgs = @{
  packageName    = $packageName
  fileType       = 'EXE'
  url            = $url
  validExitCodes = @(0,1)
  silentArgs     = ''
  softwareName   = 'Backup Manager'
  checksum       = $checksum
  checksumType   = $checksumType
}

Install-ChocolateyPackage @packageArgs
