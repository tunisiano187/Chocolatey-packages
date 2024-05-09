$ErrorActionPreference = 'Stop';
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url            = 'https://www.adiirc.com/AdiIRC.4.4.exe'
$checksum       = 'd4c0fabcd44a1db0e5b8cfb9dfb996785db6487b1e500d5a2eff28b90159090b'
$url64          = 'https://www.adiirc.com/AdiIRC64.4.4.exe'
$checksum64     = 'e5ba3854f59f9088643b7dcdf20289a66604b3607ce56130c2b8dcfad1b132bb'
$checksumType   = 'sha256'


$packageArgs = @{
  packageName     = $env:ChocolateyPackageName
  unzipLocation   = $toolsDir
  fileType        = 'EXE'
  url             = $url
  url64bit        = $url64
  softwareName    = 'AdiIRC*'
  checksum        = $checksum
  checksumType    = $checksumType
  checksum64      = $checksum64
  checksumType64  = $checksumType

  validExitCodes  = @(1223, 0, 3010, 1641)
  silentArgs      = '/S'
}

Install-ChocolateyPackage @packageArgs
