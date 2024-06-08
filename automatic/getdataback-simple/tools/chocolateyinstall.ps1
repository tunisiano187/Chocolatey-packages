$ErrorActionPreference = 'Stop'
$packageName    = 'getdataback-simple'
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url            = 'https://www.runtime.org/gdbprosetup.exe'
$checksum       = '4B894A3905EAAADD46BB9B5E7668AFAAC21F4B8573FEBB6225F52EE3E1B40D0A'

$packageArgs = @{
  packageName    = $packageName
  unzipLocation  = $toolsDir  
  fileType       = 'EXE'
  url            = $url
  validExitCodes = @(0)
  silentArgs     = '/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-'
  softwareName   = 'GetDataBack*'
  checksum       = $checksum
  checksumType   = 'sha256' 
}

Install-ChocolateyPackage @packageArgs
