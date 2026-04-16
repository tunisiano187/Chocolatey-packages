$ErrorActionPreference = 'Stop';

$packageName      = '1password-cli'
$toolsDir         = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url              = 'https://cache.agilebits.com/dist/1P/op2/pkg/v2.35.0-beta.01/op_windows_386_v2.35.0-beta.01.zip'
$checksum         = '3DC95D2640FCE9C5DF5FF78D8A15CB26CF5477AEF0301C48BC94B5129E6B65CC'
$checksumType     = 'sha256'
$url64            = 'https://cache.agilebits.com/dist/1P/op2/pkg/v2.35.0-beta.01/op_windows_amd64_v2.35.0-beta.01.zip'
$checksum64       = '3F9C5C0575C4ACC985669ECB385745EC07C62CA2684B22324FB3B3C26EAA9E69'
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
