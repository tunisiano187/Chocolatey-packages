$ErrorActionPreference = 'Stop';
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

$url64          = 'https://1111-releases.cloudflareclient.com/windows/Cloudflare_WARP_Release-x64.msi'
$checksum64     = '2D229654A6A3BABA431763000D9936DA704BEC8CC779ADA28DFFA89C3F5E538D152221AD08D80C313ABD155739FE8F6F190245CBDCF6002FE7B9B75B2C4C966C'
$checksumType64 = 'SHA512'

$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  unzipLocation = $toolsDir
  fileType      = 'EXE'
  url64bit      = $url64

  softwareName  = 'pawns*'

  checksum64    = $Checksum64
  checksumType64= $ChecksumType64

  # MSI
  silentArgs    = "/S"
  validExitCodes= @(0, 3010, 1641)
}

Install-ChocolateyPackage @packageArgs
