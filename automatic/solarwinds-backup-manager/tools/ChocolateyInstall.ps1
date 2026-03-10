$ErrorActionPreference = 'Stop'
$packageName    = 'solarwinds-backup-manager'
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url            = 'https://cdn.cloudbackup.management/maxdownloads/mxb-windows-x86_x64.exe'
$checksum       = '589DD1142ED77A56268A49F3554BD30248AD6E86892D7522D3EC505A30A92880'
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
