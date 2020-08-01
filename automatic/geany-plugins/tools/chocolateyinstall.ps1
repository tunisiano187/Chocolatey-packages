$ErrorActionPreference = 'Stop';
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url            = 'https://plugins.geany.org/geany-plugins/geany-plugins-1.36_setup.exe'
$checksum       = '0115ca49978195094a8b568901f56eb22a3682930116476462462744b974c7fb'
$checksumType   = 'sha256'

$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  unzipLocation = $toolsDir
  fileType      = 'EXE'
  url           = $url
  softwareName  = 'geany-plugins*'
  checksum      = $checksum
  checksumType  = $checksumType
  silentArgs    = '/S'
  validExitCodes= @(0)
}

Install-ChocolateyPackage @packageArgs
