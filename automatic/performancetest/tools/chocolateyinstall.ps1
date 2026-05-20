$ErrorActionPreference = 'Stop'
$packageName    = 'performancetest'
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url            = 'https://www.passmark.com/downloads/PerformanceTest_Windows_x86-64.exe'
$checksum       = 'a725c00796c55f017563839853de0780b11443051b57df86da62bf6bea280427'
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
