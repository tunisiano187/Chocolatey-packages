$ErrorActionPreference = 'Stop'
$packageName    = $env:chocolateyPackageName
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url            = 'https://github.com/Tautulli/Tautulli/releases/download/v2.17.2/Tautulli-windows-v2.17.2-x64.exe'
$checksum       = '6a1c374ee1e8d72b2b066fde3a9ae78378266c486b62f8d503d3817827888e4b'
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
