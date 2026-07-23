$ErrorActionPreference = 'Stop'
$packageName    = 'solarwinds-backup-manager'
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url            = 'https://cdn.cloudbackup.management/maxdownloads/mxb-windows-x86_x64.exe'
$checksum       = 'C472C6A31BF7A408C069F26D589597DE12137B4D65E55C59ED0FE339D18CD271'
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
