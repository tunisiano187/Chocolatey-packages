$toolsDir     = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url          = 'https://psychz.dl.sourceforge.net/project/projectlibre/ProjectLibre/1.9.8/projectlibre-1.9.8.zip?viasf=1'
$checksum     = '380c569399cfd54471bf45f33f8df08818b3a0d12a1f8724b96dade0ebfcce9a'
$checksumType = 'sha256'

$packageArgs = @{
    packageName   = $env:ChocolateyPackageName
    url           = $url
    checksum      = $checksum
    checksumType  = $checksumType

    UnzipLocation = $toolsDir
  }

  Install-ChocolateyZipPackage @packageArgs
