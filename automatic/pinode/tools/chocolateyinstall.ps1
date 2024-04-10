$ErrorActionPreference = 'Stop';

$packageName      = $env:ChocolateyPackageName
$toolsDir         = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url              = 'https://downloads.minepi.com/Pi%20Network%20Setup%200.4.10.exe'
$checksum         = '7cde87628af4a0bbb05856809d6b59666a22e01d7593f732b8ab91fea530503a'
$checksumType     = 'sha256'

$packageArgs = @{
  packageName     = $packageName
  unzipLocation   = $toolsDir
  fileType        = 'EXE'
  url             = $url

  softwareName    = 'Pi Network*'

  checksum        = $checksum
  checksumType    = $checksumType

  validExitCodes= @(0, 3010, 1641)
  silentArgs   = '/S'
}

Install-ChocolateyPackage @packageArgs
