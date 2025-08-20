$ErrorActionPreference = 'Stop';

$packageName      = '1password-cli'
$toolsDir         = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url              = 'https://cache.agilebits.com/dist/1P/op2/pkg/v2.32.0/op_windows_386_v2.32.0.zip'
$checksum         = 'AC65421654C401CBC73CD75BCE909AB74299197B467ED6A27C474678FA6C2299'
$checksumType     = 'sha256'
$url64            = 'https://cache.agilebits.com/dist/1P/op2/pkg/v2.32.0/op_windows_amd64_v2.32.0.zip'
$checksum64       = '7FBA6D1F4DF4EAF8DB814E0B3E8C697CB46599BDA691F7755C97988BA1CB339A'
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
