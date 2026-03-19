$ErrorActionPreference = 'Stop';

$packageName      = '1password-cli'
$toolsDir         = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url              = 'https://cache.agilebits.com/dist/1P/op2/pkg/v2.34.0-beta.03/op_windows_386_v2.34.0-beta.03.zip'
$checksum         = '38C2CFB9D5EEB2012A54BE195FFA1A73705FB5564A0968C03CB037149027B35F'
$checksumType     = 'sha256'
$url64            = 'https://cache.agilebits.com/dist/1P/op2/pkg/v2.34.0-beta.03/op_windows_amd64_v2.34.0-beta.03.zip'
$checksum64       = '76FF76FCC40D9B40293277EA2EEBE38FAA4F340A332611A70CF412A79C2E1827'
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
