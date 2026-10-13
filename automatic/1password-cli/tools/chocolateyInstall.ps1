$ErrorActionPreference = 'Stop';

$packageName      = '1password-cli'
$toolsDir         = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url              = 'https://cache.agilebits.com/dist/1P/op2/pkg/v2.41.0/op_windows_386_v2.41.0.zip'
$checksum         = '4A2776B27F3DA6003A62D47EA415A383A2D6A68120939D5FF33A72D1E95CCA29'
$checksumType     = 'sha256'
$url64            = 'https://cache.agilebits.com/dist/1P/op2/pkg/v2.41.0/op_windows_amd64_v2.41.0.zip'
$checksum64       = '1338A6799EF9F66D1B7D526FCF195A37675E80171C557DED01AFEBB159E3490B'
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
