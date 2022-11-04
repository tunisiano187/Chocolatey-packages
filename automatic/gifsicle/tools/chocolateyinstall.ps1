
$ErrorActionPreference = 'Stop';

$packageName= 'gifsicle'
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url        = 'https://eternallybored.org/misc/gifsicle/releases/gifsicle-1.89-win32.zip'
$url64      = 'https://eternallybored.org/misc/gifsicle/releases/gifsicle-1.89-win64.zip'

$packageArgs = @{
  packageName   = $packageName
  unzipLocation = $toolsDir
  Url           = $url
  Url64Bit      = $url64

  softwareName  = 'gifsicle*'

  Checksum      = 'D9B2B29F383B5235BE6C3518131FEBD55C1A4BB48CB39975CBAC13E073094938'
  ChecksumType  = 'sha256'
  Checksum64    = '8C1FE58644FDDC8FC1E3CCD97A048630F8E1E0DF196931825DFBE5C3F93882F5'
  ChecksumType64= 'sha256'

}

Install-ChocolateyZipPackage @packageArgs


















