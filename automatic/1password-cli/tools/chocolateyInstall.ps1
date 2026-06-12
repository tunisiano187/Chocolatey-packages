$ErrorActionPreference = 'Stop';

$packageName      = '1password-cli'
$toolsDir         = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url              = 'https://cache.agilebits.com/dist/1P/op2/pkg/v2.34.1/op_windows_386_v2.34.1.zip'
$checksum         = 'ED9708FCE28D2313078FEBEC90D90748A89A5B3F4555799CE28C2789527DD086'
$checksumType     = 'sha256'
$url64            = 'https://cache.agilebits.com/dist/1P/op2/pkg/v2.34.1/op_windows_amd64_v2.34.1.zip'
$checksum64       = '25B25226AE1B5E1D6AA42EE8B9C6D1B956797E495A989B458F1DCC23D17611BF'
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
