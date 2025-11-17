$ErrorActionPreference = 'Stop'
$packageName    = 'ntlite-free'
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url            = 'https://downloads.ntlite.com/files/NTLite_setup_x86.exe'
$checksum       = 'd42c293351426878b05e98ad7f0cd855399045c2ef4c225d34adee24b83f14f9'
$checksumType   = 'sha256'
$url64          = 'https://downloads.ntlite.com/files/NTLite_setup_x64.exe'
$checksum64     = '412c2b0426c6a9470c182562dd67ca37a6d5e8a22ae7de78e57b309ee5b952a5'
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
