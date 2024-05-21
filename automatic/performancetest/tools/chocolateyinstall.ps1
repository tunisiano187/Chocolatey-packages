$ErrorActionPreference = 'Stop'
$packageName    = 'performancetest'
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url            = 'https://www.passmark.com/downloads/petst.exe'
$checksum       = '22b5fd188eb93fe8ebc3abedb541388cb6e16fc3b3f5ca7f1f8d27bfd46a9a81'
$checksumType   = 'sha256'

$packageArgs = @{
  packageName    = $packageName
  unzipLocation  = $toolsDir
  fileType       = 'EXE'
  url            = $url
  validExitCodes = @(0)
  silentArgs     = '/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-'
  softwareName   = 'PerformanceTest*'
  checksum       = $checksum
  checksumType   = $checksumType
}

Install-ChocolateyPackage @packageArgs
