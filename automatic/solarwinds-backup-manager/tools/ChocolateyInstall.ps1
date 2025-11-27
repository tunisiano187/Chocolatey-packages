$ErrorActionPreference = 'Stop'
$packageName    = 'solarwinds-backup-manager'
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url            = 'https://cdn.cloudbackup.management/maxdownloads/mxb-windows-x86_x64.exe'
$checksum       = '9542C563E7068B3050E2FC55C2A519ECF9C198459B530AEEF95F1C1507731A44'
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
