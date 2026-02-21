$ErrorActionPreference = 'Stop'
$packageName    = $env:ChocolateyPackageName
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url            = 'https://github.com/duplicati/duplicati/releases/download/v2.2.0.105_canary_2026-02-20/duplicati-2.2.0.105_canary_2026-02-20-win-x64-gui.zip'
$checksum       = 'edff9d883097c4f57d15b02a62a375624b28a0f036e53e72a0b3310e22754e28'
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
