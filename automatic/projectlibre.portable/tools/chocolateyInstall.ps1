$toolsDir     = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url          = 'http://sourceforge.net/projects/projectlibre/files/ProjectLibre/1.5.9/projectlibre-1.5.9.msi/download'
$checksum     = ''
$checksumType = ''

$packageArgs = @{
    packageName   = $env:ChocolateyPackageName
    url           = $url
    checksum      = $checksum
    checksumType  = $checksumType

    UnzipLocation = $toolsDir
  }

  Install-ChocolateyZipPackage @packageArgs
