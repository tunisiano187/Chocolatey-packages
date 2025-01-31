$ErrorActionPreference = 'Stop'
$packageName    = $env:ChocolateyPackageName
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url            = 'https://github.com/duplicati/duplicati/releases/download/v2.1.0.108_canary_2025-01-31/duplicati-2.1.0.108_canary_2025-01-31-win-x64-gui.zip'
$checksum       = 'c093ea966065ceb161d026aba2b7bdf65ec0cbb8cbb70a9ec1abc078cf7adead'
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
