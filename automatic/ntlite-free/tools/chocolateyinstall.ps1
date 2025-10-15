$ErrorActionPreference = 'Stop'
$packageName    = 'ntlite-free'
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url            = 'https://downloads.ntlite.com/files/NTLite_setup_x86.exe'
$checksum       = 'ca6dd13b42c7789fecaf4a433cd5d4d337ab3058de9df7439e85aa82422c84a7'
$checksumType   = 'sha256'
$url64          = 'https://downloads.ntlite.com/files/NTLite_setup_x64.exe'
$checksum64     = '0be5a36f9f64c985614b6b26cde2e9532c051cd2876c2b7d16902ee8f74ffe98'
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
