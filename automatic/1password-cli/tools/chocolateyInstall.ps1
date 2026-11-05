$ErrorActionPreference = 'Stop';

$packageName      = '1password-cli'
$toolsDir         = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url              = 'https://cache.agilebits.com/dist/1P/op2/pkg/v2.42.0/op_windows_386_v2.42.0.zip'
$checksum         = '2A1104BABBD679859CA811D7011029B94FD56E9FFAABFCA5F2C534748465E72B'
$checksumType     = 'sha256'
$url64            = 'https://cache.agilebits.com/dist/1P/op2/pkg/v2.42.0/op_windows_amd64_v2.42.0.zip'
$checksum64       = '8C457A0DC852C15BEB35AF77717ED32294345A300E15C444ED42C79EBC4330E9'
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
