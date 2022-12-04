$toolsDir     = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url          = 'https://netix.dl.sourceforge.net/project/projectlibre/ProjectLibre/1.9.3/projectlibre-1.9.3.zip'
$checksum     = '1256fa9d4906a957389ae6f35e79b9d84a90c15d2c432cdd916ffff420f7c1ec'
$checksumType = 'sha256'

$packageArgs = @{
    packageName   = $env:ChocolateyPackageName
    url           = $url
    checksum      = $checksum
    checksumType  = $checksumType

    UnzipLocation = $toolsDir
  }

  Install-ChocolateyZipPackage @packageArgs
