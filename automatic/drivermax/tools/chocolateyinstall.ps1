$ErrorActionPreference = 'Stop'
$packageName  = $env:ChocolateyPackageName
$toolsDir     = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url          = 'https://www.drivermax.com/soft/dmx/drivermax.exe'
$checksum     = '76df6126f91b19058980401bc48dfb886c61e33b69899334ad170f73c1b4e8d0'
$checksumType = 'sha256'

$packageArgs = @{
  packageName    = $packageName
  unzipLocation  = $toolsDir
  fileType       = 'EXE'
  url            = $url
  validExitCodes = @(0,1)
  silentArgs     = '/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP- /CLOSEAPPLICATIONS'
  softwareName   = 'DriverMax*'
  checksum       = $checksum
  checksumType   = $checksumType
}

Install-ChocolateyPackage @packageArgs
