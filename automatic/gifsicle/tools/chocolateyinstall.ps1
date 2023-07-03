
$ErrorActionPreference = 'Stop';

$packageName    = $env:ChocolateyPackageName
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url32          = 'https://eternallybored.org/misc/gifsicle/releases/gifsicle-1.94-win32.zip'
$checksum32     = '79b0d71d4bf9038a456060d4fc9ade176db234c22bbd6c5c46a9cf6bc41377c4'
$checksumType32 = 'sha256'
$url64          = 'https://eternallybored.org/misc/gifsicle/releases/gifsicle-1.94-win64.zip'
$checksum64     = 'b3e3a9e0c8ade061b5b2ef13cad3d4ad57466400552a78ed285ed0c3f97a5141'
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


















