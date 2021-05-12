$ErrorActionPreference = 'Stop';

$packageName      = $env:ChocolateyPackageName
$toolsDir         = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url              = 'https://node-cdn.minepi.com/Pi%20Network%20Setup%200.4.4.exe'
$checksum         = '1b338264420c4446b0a6e5993995b9dcb2886b18ece81caaa38523c3b6eacc39'
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
