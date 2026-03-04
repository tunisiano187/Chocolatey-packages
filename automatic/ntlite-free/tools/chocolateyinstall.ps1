$ErrorActionPreference = 'Stop'
$packageName    = 'ntlite-free'
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url            = 'https://downloads.ntlite.com/files/NTLite_setup_x86_legacy.exe'
$checksum       = '5dc9e87ec89ba8b7fca153c40dbac9e7b2f653e34cf041f23a0880cbea577a1b'
$checksumType   = 'sha256'
$url64          = 'https://downloads.ntlite.com/files/NTLite_setup_x64.exe'
$checksum64     = '89efaecf1980669f6f99904bb1e87f865926df058c95f1214264faeba5995b4e'
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
