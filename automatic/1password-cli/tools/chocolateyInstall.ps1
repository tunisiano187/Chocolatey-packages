$ErrorActionPreference = 'Stop';

$packageName      = '1password-cli'
$toolsDir         = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url              = 'https://cache.agilebits.com/dist/1P/op2/pkg/v2.40.0/op_windows_386_v2.40.0.zip'
$checksum         = 'B6B61E984C2B866B0F9A6804EDAB3258C98FA2F2516851D6C1B2D60B9D6E32B2'
$checksumType     = 'sha256'
$url64            = 'https://cache.agilebits.com/dist/1P/op2/pkg/v2.40.0/op_windows_amd64_v2.40.0.zip'
$checksum64       = 'EDC4519F8A7215E81031C0FF3EE1AA99EB79E6E5C771D152BEEA4FB66975FAAE'
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
