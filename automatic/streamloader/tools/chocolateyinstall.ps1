
$ErrorActionPreference = 'Stop'

$toolsDir     = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url          = 'https://xstreamloader.techweb.at/download/streamlink-package/X-StreamLoader.zip'
$checksum     = '82610454bb51f70f5a35843c615ada1b9d195f39b564e349bb9e4c7550b55e04'
$checksumType = 'sha256'

$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  unzipLocation = $toolsDir
  url           = $url

  checksum      = $checksum
  checksumType  = $checksumType
}

Install-ChocolateyZipPackage @packageArgs
