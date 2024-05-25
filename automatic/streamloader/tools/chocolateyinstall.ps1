
$ErrorActionPreference = 'Stop'

$toolsDir     = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url          = '{{DownloadUrl}}'
$checksum     = ''
$checksumType = ''

$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  unzipLocation = $toolsDir
  url           = $url

  checksum      = $checksum
  checksumType  = $checksumType
}

Install-ChocolateyZipPackage @packageArgs

















