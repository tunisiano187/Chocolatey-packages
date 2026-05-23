
$ErrorActionPreference = 'Stop'

$toolsDir     = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url          = 'https://xstreamloader.techweb.at/download/streamlink-package/X-StreamLoader.zip'
$checksum     = 'ea5867624cf65315457715fb786493ad3164ae93c6cf557b3dc2aad951dbe3e2'
$checksumType = 'sha256'

$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  unzipLocation = $toolsDir
  url           = $url

  checksum      = $checksum
  checksumType  = $checksumType
}

Install-ChocolateyZipPackage @packageArgs
