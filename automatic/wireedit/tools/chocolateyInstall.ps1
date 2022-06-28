$ErrorActionPreference = 'Stop'
$installerType  = 'msi'
$url            = 'https://omnipacket.com/current/WireEdit-3.10.154.msi'
$silentArgs     = '/quiet'
$checksum       = '70dd12ee3e3605c594fe222127b69d395df63d4a504e75bb96df56d931f34a24'
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
