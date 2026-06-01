$ErrorActionPreference = 'Stop'
$packageName    = 'ntlite-free'
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url            = 'https://downloads.ntlite.com/files/NTLite_setup_x86_legacy.exe'
$checksum       = '40c2bc0f4195e264d55fbe0fa038be3e8bcc9f1e2b7c3d6bc7219471f93ed21c'
$checksumType   = 'sha256'
$url64          = 'https://downloads.ntlite.com/files/NTLite_setup_x64.exe'
$checksum64     = 'd02b30d08669f7fa2417bca80d1485e868c7a2695ecd2c2a3fc29c26b011c2f4'
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
