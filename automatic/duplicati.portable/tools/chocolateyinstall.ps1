$ErrorActionPreference = 'Stop'
$packageName    = $env:ChocolateyPackageName
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url            = 'https://github.com/duplicati/duplicati/releases/download/v2.4.0.100_canary_2026-09-04/duplicati-2.4.0.100_canary_2026-09-04-win-x64-gui.zip'
$checksum       = '5a68979dc7367e61f027e9546ec200e0d26311295ddc7f508abf326c3683ecb6'
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
