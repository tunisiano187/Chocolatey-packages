$ErrorActionPreference = 'Stop'; # stop on all errors
$toolsDir     = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

$url          = 'https://github.com/fossasia/pslab-desktop/releases/download/v2.8.1/PSLab-Desktop-Setup-2.8.1.exe'
$checksum     = 'cd7b845847dfde8c47ad205a7b3612b42c20da648393c63c60bf9408a5efbcb1'
$checksumType = 'sha256'

$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  unzipLocation = $toolsDir
  fileType      = 'EXE'
  url           = $url

  softwareName  = 'pslab-desktop*'

  checksum      = $checksum
  checksumType  = $checksumType

  silentArgs   = '/S'
}

Install-ChocolateyPackage @packageArgs
