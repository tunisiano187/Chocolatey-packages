$ErrorActionPreference = 'Stop';

$packageName      = '1password-cli'
$toolsDir         = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url              = 'https://cache.agilebits.com/dist/1P/op2/pkg/v2.39.0/op_windows_386_v2.39.0.zip'
$checksum         = '79D9BC6A2B2B9F38CBE8076C0E0756F707BE9B4320AA754588EFF5B64C928087'
$checksumType     = 'sha256'
$url64            = 'https://cache.agilebits.com/dist/1P/op2/pkg/v2.39.0/op_windows_amd64_v2.39.0.zip'
$checksum64       = '38B3748D76D104469EB6E2744F843D2A7E03D1B6D330CC42D600CFF379C37BAB'
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
