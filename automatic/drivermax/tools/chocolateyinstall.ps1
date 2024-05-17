$ErrorActionPreference = 'Stop'
$packageName = 'drivermax'
$toolsDir    = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url         = 'https://www.drivermax.com/soft/dmx/drivermax.exe'
$checksum    = '1C906D8A663FBE88EED21C8D38F8DA7F66EFA962445A14B48846EAE53F658BE4'

$packageArgs = @{
  packageName    = $packageName
  unzipLocation  = $toolsDir
  fileType       = 'EXE'
  url            = $url
  validExitCodes = @(0,1)
  silentArgs     = '/SP- /VERYSILENT /SUPPRESSMSGBOXES /CLOSEAPPLICATIONS'
  softwareName   = 'DriverMax*'
  checksum       = $checksum
  checksumType   = 'sha256'
  }

Install-ChocolateyPackage @packageArgs

# Update instructions:
# Update checksum
