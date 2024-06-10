$ErrorActionPreference = 'Stop'
$packageName    = 'getdataback-simple'
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url            = 'https://www.runtime.org/gdbprosetup.exe'
$checksum       = 'f0fe269803f01dd28ea807db8e3e02828507d38072f0edce0b13e582091e2cdc'
$checksumType   = 'sha256'

$packageArgs = @{
  packageName    = $packageName
  unzipLocation  = $toolsDir
  fileType       = 'EXE'
  url            = $url
  validExitCodes = @(0)
  silentArgs     = '/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-'
  softwareName   = 'GetDataBack*'
  checksum       = $checksum
  checksumType   = $checksumType
}

Install-ChocolateyPackage @packageArgs
