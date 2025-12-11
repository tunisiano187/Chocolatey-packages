$ErrorActionPreference = 'Stop'
$packageName    = 'solarwinds-backup-manager'
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url            = 'https://cdn.cloudbackup.management/maxdownloads/mxb-windows-x86_x64.exe'
$checksum       = '8A9F0BD483069EE51715D1758AF7C2C68EC5E9A893D03587AD88C7EB3F26884C'
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
