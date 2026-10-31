$ErrorActionPreference = 'Stop'
$packageName    = $env:ChocolateyPackageName
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url            = 'https://github.com/duplicati/duplicati/releases/download/v2.4.1.100_canary_2026-10-31/duplicati-2.4.1.100_canary_2026-10-31-win-x64-gui.zip'
$checksum       = '1221bb3b3ccd4a1b46040d9f75bdfaf54222b608a322faa6b652dfb90200b519'
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
