$ErrorActionPreference = 'Stop';

$packageName  = $env:ChocolateyPackageName
$toolsDir     = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url          = 'https://github.com/rubberduck-vba/Rubberduck/releases/download/Prerelease-v2.5.1.5739/Rubberduck.Setup.2.5.1.5739-pre.exe' # download url
$checksum     = '36cce8a608855a3a4201d23e5c949d8f385ac8f11e9f083666d969dd4ee8ad77'
$checksumType = 'sha256'

$packageArgs = @{
  packageName   = $packageName
  unzipLocation = $toolsDir
  fileType      = 'exe'
  url           = $url
  checksum      = $checksum
  checksumType  = $checksumType
  silentArgs    = "/VERYSILENT"
}

Install-ChocolateyPackage @packageArgs
