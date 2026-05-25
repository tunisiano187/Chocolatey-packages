$ErrorActionPreference = 'Stop';

$packageName      = '1password-cli'
$toolsDir         = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url              = 'https://cache.agilebits.com/dist/1P/op2/pkg/v2.34.0/op_windows_386_v2.34.0.zip'
$checksum         = 'DB46E206C3316EFCD0B26F03F78F57C20AA1C763CF99301802E84621B41A80CF'
$checksumType     = 'sha256'
$url64            = 'https://cache.agilebits.com/dist/1P/op2/pkg/v2.34.0/op_windows_amd64_v2.34.0.zip'
$checksum64       = 'EA1FDEA5BC52A8CFF3F6B502C03EC5A567CD6E97D38FAC35C511841E7DFD67FC'
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
