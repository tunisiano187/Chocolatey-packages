$ErrorActionPreference = 'Stop'
$packageName    = 'performancetest'
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url            = 'https://www.passmark.com/downloads/petst.exe'
$checksum       = 'be8f19006c6f15ed374ac71a99ce7ea0fc4426d453ead4ecef25a6a87efd755c'
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
