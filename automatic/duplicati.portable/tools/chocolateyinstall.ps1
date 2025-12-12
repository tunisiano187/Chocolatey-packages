$ErrorActionPreference = 'Stop'
$packageName    = $env:ChocolateyPackageName
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url            = 'https://github.com/duplicati/duplicati/releases/download/v2.2.0.102_canary_2025-12-12/duplicati-2.2.0.102_canary_2025-12-12-win-x64-gui.zip'
$checksum       = 'b19f143719253634058c0d884fb323c8c3a9cb327ef2f3d32db11a051b88ba65'
$checksumType   = 'sha256'


$packageArgs = @{
  packageName   = $packageName
  unzipLocation = $toolsDir
  fileType      = 'ZIP'
  url           = $url
  checksum      = $checksum
  checksumType  = $checksumType
}

Install-ChocolateyZipPackage @packageArgs
