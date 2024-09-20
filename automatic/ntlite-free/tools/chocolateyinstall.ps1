$ErrorActionPreference = 'Stop'
$packageName    = 'ntlite-free'
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url            = 'http://downloads.ntlite.com/files/NTLite_setup_x86.exe'
$checksum       = 'FA2AC26D0A4E7930B9A19373EB0640CFE8F1863812498482B84C575246D15275'
$url64          = 'http://downloads.ntlite.com/files/NTLite_setup_x64.exe'
$checksum64     = '402314245E6CFED2E3E61C0D305FF99593F0D8C623D1718B4372B4D827381B5B'

$packageArgs = @{
  packageName    = $packageName
  fileType       = 'EXE'
  url            = $url
  url64bit       = $url64
  validExitCodes = @(0)
  silentArgs     = '/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-'
  softwareName   = 'NTLite*'
  checksum       = $checksum
  checksumType   = 'sha256'
  checksum64     = $checksum64
  checksumType64 = 'sha256'
}

Install-ChocolateyPackage @packageArgs
