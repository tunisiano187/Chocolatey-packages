$ErrorActionPreference = 'Stop'
$packageName    = $env:chocolateyPackageName
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url            = 'https://github.com/Tautulli/Tautulli/releases/download/v2.16.1/Tautulli-windows-v2.16.1-x64.exe'
$checksum       = 'e1ec11e0b61ac21f1a15d2a41f05dce42a453e46e639d60b0faa6cfde45f78ea'
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
