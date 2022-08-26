$ErrorActionPreference = 'Stop'
$installerType  = 'msi'
$url            = 'https://omnipacket.com/current/WireEdit-3.10.254.msi'
$silentArgs     = '/quiet'
$checksum       = '2017ddeda07a3e3eec6b4273cf20c9f8a93d2bd08f8d2d66daa9085c86a229a0'
$checksumType   = 'sha256'

$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  fileType      = $installerType
  url           = $url
  checksum      = $checksum
  checksumType  = $checksumType
  silentArgs    = $silentArgs
  validExitCodes= @(0)
}

Install-ChocolateyPackage @packageArgs
