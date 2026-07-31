$ErrorActionPreference = 'Stop';

$packageName      = '1password-cli'
$toolsDir         = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url              = 'https://cache.agilebits.com/dist/1P/op2/pkg/v2.38.1/op_windows_386_v2.38.1.zip'
$checksum         = '246EEB7888FABA08C1F529990329E85FB150A37C1E6C1C8EC118FF498BD1AA6B'
$checksumType     = 'sha256'
$url64            = 'https://cache.agilebits.com/dist/1P/op2/pkg/v2.38.1/op_windows_amd64_v2.38.1.zip'
$checksum64       = '33CA7A806BEF7AD479C10D8694CFC8798D22ACDEA8FE237B92FBE1D3E5ECFD2A'
$checksumType64   = 'sha256'

$packageArgs = @{
  packageName    = $packageName
  unzipLocation  = $toolsDir
  url            = $url
  checksum       = $checksum
  checksumType   = $checksumType
  url64          = $url64
  checksum64     = $checksum64
  checksumType64 = $checksumType64
}

Install-ChocolateyZipPackage @packageArgs
