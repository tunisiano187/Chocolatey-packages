
$ErrorActionPreference = 'Stop';

$packageName    = $env:ChocolateyPackageName
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url32          = 'https://eternallybored.org/misc/gifsicle/releases/gifsicle-1.92-win32.zip'
$checksum32     = '302514ddd303e6f0a5d23157f1d1552b22ab89a80715f9b87807e98d79b5b3e3'
$checksumType32 = 'sha256'
$url64          = 'https://eternallybored.org/misc/gifsicle/releases/gifsicle-1.92-win64.zip'
$checksum64     = 'de06320f02a1aa5330a084a0d7d1aeae370ec0ce51992bef64881b0ebcabaff9'
$checksumType64 = 'sha256'

$packageArgs = @{
  packageName   = $packageName
  unzipLocation = $toolsDir
  Url           = $url32
  Url64Bit      = $url64

  softwareName  = "$($packageName)*"

  Checksum      = $checksum32
  ChecksumType  = $checksumType32
  Checksum64    = $checksum64
  ChecksumType64= $checksumType64

}

Install-ChocolateyZipPackage @packageArgs


















