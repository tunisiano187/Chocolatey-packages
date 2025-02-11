$ErrorActionPreference = 'Stop'
$packageName    = 'performancetest'
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url            = 'https://www.passmark.com/downloads/petst.exe'
$checksum       = '9016b452a1c5e578eda276d27a34ab827459edc3076c453b35ce6f5ca9594d0d'
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
