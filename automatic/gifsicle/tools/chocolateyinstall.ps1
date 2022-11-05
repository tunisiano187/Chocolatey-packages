
$ErrorActionPreference = 'Stop';

$packageName    = $env:ChocolateyPackageName
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url32          = 'https://eternallybored.org/misc/gifsicle/releases/gifsicle-1.89-win32.zip'
$checksum32     = ''
$checksumType32 = ''
$url64          = 'https://eternallybored.org/misc/gifsicle/releases/gifsicle-1.89-win64.zip'
$checksum64     = ''
$checksumType64 = ''

$packageArgs = @{
  packageName   = $packageName
  unzipLocation = $toolsDir
  Url           = $url32
  Url64Bit      = $url64

  softwareName  = "$($packageName)*"

  Checksum      = $checksum32
  ChecksumType  = $checksum32Type
  Checksum64    = $checksum64
  ChecksumType64= $checksum64Type

}

Install-ChocolateyZipPackage @packageArgs


















