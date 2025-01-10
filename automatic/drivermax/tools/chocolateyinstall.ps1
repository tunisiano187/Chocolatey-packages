$ErrorActionPreference = 'Stop'
$packageName  = $env:ChocolateyPackageName
$toolsDir     = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url          = 'https://www.drivermax.com/soft/dmx/drivermax.exe'
$checksum     = 'd692d93faed42c6238ebfbe002db7484fccde8019b9f5d5b1bf483d5d77931f2'
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
