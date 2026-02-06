$ErrorActionPreference = 'Stop';

$packageName      = '1password-cli'
$toolsDir         = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url              = 'https://cache.agilebits.com/dist/1P/op2/pkg/v2.33.0-beta.01/op_windows_386_v2.33.0-beta.01.zip'
$checksum         = '9AD4E38AB060DC17E0073294C292E066A9188000A0C8058DA29D7EA98ACD20D7'
$checksumType     = 'sha256'
$url64            = 'https://cache.agilebits.com/dist/1P/op2/pkg/v2.33.0-beta.01/op_windows_amd64_v2.33.0-beta.01.zip'
$checksum64       = '03403CCF5883E2182B63D39356F87D4C1C9AF9386FCE71E636C3007739579B66'
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
