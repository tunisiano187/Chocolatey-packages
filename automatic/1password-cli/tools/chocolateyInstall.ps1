$ErrorActionPreference = 'Stop';

$packageName      = '1password-cli'
$toolsDir         = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url              = 'https://cache.agilebits.com/dist/1P/op/pkg/$version/op_windows_386_$version.zip'
$checksum         = '7432FB0282F66929746DAB531143F0CC4D6A0F67328DDCA6AF6E3C8B92C9561F'
$checksumType     = ''
$url64            = 'https://cache.agilebits.com/dist/1P/op/pkg/$version/op_windows_amd64_$version.zip'
$checksum64       = 'CD6A7D24E63DF4F8B3933F74B86740520DDBAD716E9847CDF161AE40AF101DDC'
$checksumType64   = ''

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