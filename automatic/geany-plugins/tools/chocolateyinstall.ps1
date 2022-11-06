$ErrorActionPreference = 'Stop';
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url            = 'https://plugins.geany.org/geany-plugins/geany-plugins-1.38_setup.exe'
$checksum       = '3bb95f8aed7e37de495b899865d9fc51b951e7385842f2c11df2cdddbd5f80f6'
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
