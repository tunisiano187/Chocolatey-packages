
$ErrorActionPreference = 'Stop';

$packageName    = $env:ChocolateyPackageName
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url32          = 'https://eternallybored.org/misc/gifsicle/releases/gifsicle-1.95-win32.zip'
$checksum32     = 'f31464e334b9fb83d4dc60a25bde7cfa35829564bc378c40f0d3c6350910256c'
$checksumType32 = 'sha256'
$url64          = 'https://eternallybored.org/misc/gifsicle/releases/gifsicle-1.95-win64.zip'
$checksum64     = '7e47dd0bfd5ee47f911464c57faeed89a8709a7625dd1c449b16579889539ee8'
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


















