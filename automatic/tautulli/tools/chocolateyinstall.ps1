$ErrorActionPreference = 'Stop'
$packageName    = $env:chocolateyPackageName
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url            = 'https://github.com/Tautulli/Tautulli/releases/download/v2.17.1/Tautulli-windows-v2.17.1-x64.exe'
$checksum       = 'b2ad159276c41621424611ee5b50b3111c256ed90a92b89ca3b7c64f17ed033f'
$checksumType   = 'sha256'

$packageArgs = @{
  packageName  = $packageName
  fileType     = 'EXE'
  url          = $url
  checksum     = $checksum
  checksumType = $checksumType
  silentArgs   = '/S'
  softwareName = "tautulli"
}

Install-ChocolateyPackage @packageArgs
