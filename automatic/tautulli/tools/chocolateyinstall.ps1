$ErrorActionPreference = 'Stop'
$packageName    = $env:chocolateyPackageName
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url            = 'https://github.com/Tautulli/Tautulli/releases/download/v2.18.2/Tautulli-windows-v2.18.2-x64.exe'
$checksum       = '650b907c445244067e7ba8040273e428c54721eac5e5906915ba8973b109fc7e'
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
