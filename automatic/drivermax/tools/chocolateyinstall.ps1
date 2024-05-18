$ErrorActionPreference = 'Stop'
$packageName  = $env:ChocolateyPackageName 
$toolsDir     = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url          = 'https://www.drivermax.com/soft/dmx/drivermax.exe'
$checksum     = '1C906D8A663FBE88EED21C8D38F8DA7F66EFA962445A14B48846EAE53F658BE4'
$checksumType = ''

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
