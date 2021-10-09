$ErrorActionPreference = 'Stop';

$packageName  = $env:ChocolateyPackageName
$toolsDir     = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url          = 'https://github.com/rubberduck-vba/Rubberduck/releases/download/Prerelease-v2.5.2.5987/Rubberduck.Setup.2.5.2.5987-pre.exe' # download url
$checksum     = '26ce38a2b75b2cf2547a3c785d1576d9f7ebd11aa04979f213be4bd34ea4e340'
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
