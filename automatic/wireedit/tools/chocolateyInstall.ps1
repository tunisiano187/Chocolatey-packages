$ErrorActionPreference = 'Stop'
$installerType  = 'msi'
$url            = 'https://omnipacket.com/current/WireEdit-2.22.240.msi'
$silentArgs     = '/quiet'
$checksum       = '9cf349b868c27ebe2a2729e5241790f9efb67bf2df31631346e32372fbbd8e14'
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
