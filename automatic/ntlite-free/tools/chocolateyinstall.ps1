$ErrorActionPreference = 'Stop'
$packageName    = 'ntlite-free'
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url            = 'https://downloads.ntlite.com/files/NTLite_setup_x86_legacy.exe'
$checksum       = '9e0999b1eeae484dec1a2cef20d79576ebe4e5eb7911e518845ba06ea5c0f50a'
$checksumType   = 'sha256'
$url64          = 'https://downloads.ntlite.com/files/NTLite_setup_x64.exe'
$checksum64     = '579e61e0cffdd69272173e3d23f1e55a215015697e210f22e57442bfb377b94d'
$checksumType64 = 'sha256'

$packageArgs = @{
  packageName    = $packageName
  fileType       = 'EXE'
  url            = $url
  url64bit       = $url64
  validExitCodes = @(0)
  silentArgs     = '/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-'
  softwareName   = 'NTLite*'
  checksum       = $checksum
  checksumType   = $checksumType
  checksum64     = $checksum64
  checksumType64 = $checksumType64
}

Install-ChocolateyPackage @packageArgs
