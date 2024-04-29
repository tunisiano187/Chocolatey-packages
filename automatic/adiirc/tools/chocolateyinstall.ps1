$ErrorActionPreference = 'Stop';
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url            = 'https://www.adiirc.com/AdiIRC.3.3.exe'
$checksum       = ''
$url64          = 'https://www.adiirc.com/AdiIRC64.3.3.exe'
$checksum64     = ''
$checksumType   = ''


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
