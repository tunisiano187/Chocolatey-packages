$ErrorActionPreference = 'Stop';

$packageName      = '1password-cli'
$toolsDir         = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url              = 'https://cache.agilebits.com/dist/1P/op2/pkg/v2.41.1/op_windows_386_v2.41.1.zip'
$checksum         = '6CA33A72BFDC2758BA090850ED37B13C956C6CCD7EFEFEFFFFF3B7CA430DE003'
$checksumType     = 'sha256'
$url64            = 'https://cache.agilebits.com/dist/1P/op2/pkg/v2.41.1/op_windows_amd64_v2.41.1.zip'
$checksum64       = '7C7AB33E0C1096DB62645B72BDF3E284E8734CD39EE0175922EF7AB2A18370DA'
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
