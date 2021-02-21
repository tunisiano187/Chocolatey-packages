$ErrorActionPreference = 'Stop'; # stop on all errors
$toolsDir     = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

$url          = 'https://github.com/fossasia/pslab-desktop/releases/download/v2.6.0/PSLab-Desktop-Setup-2.6.0.exe'
$checksum     = 'd54073a230ebe3783055dfb0d721162af4c269ded0171472c3bf88ba7b720c05'
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
