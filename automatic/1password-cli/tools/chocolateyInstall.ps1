$ErrorActionPreference = 'Stop';

$packageName      = '1password-cli'
$toolsDir         = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url              = 'https://cache.agilebits.com/dist/1P/op2/pkg/v2.31.1/op_windows_386_v2.31.1.zip'
$checksum         = '33739DA463138B52FD65992BDC8D6513F85E0B97C6C2BBEEFB02FD18756ED3FF'
$checksumType     = 'sha256'
$url64            = 'https://cache.agilebits.com/dist/1P/op2/pkg/v2.31.1/op_windows_amd64_v2.31.1.zip'
$checksum64       = '7CF3A30BDE910A8087052CD453186F80B72931B94FD4E90B4C6F5485C436B451'
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
