$ErrorActionPreference = 'Stop'; # stop on all errors
$toolsDir     = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

$url          = ''
$checksum     = ''
$checksumType = ''

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