$ErrorActionPreference = 'Stop';

$packageName      = $env:ChocolateyPackageName
$toolsDir         = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url              = 'https://downloads.minepi.com/Pi%20Network%20Setup%200.5.0.exe'
$checksum         = 'fc31852db38e8a6a51991ca082d7982f93ff370623c7ab8068d3415862cd83c6'
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
