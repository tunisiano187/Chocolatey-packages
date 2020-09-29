$ErrorActionPreference = 'Stop';

$packageName  = $env:ChocolateyPackageName
$toolsDir     = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url          = 'https://github.com/rubberduck-vba/Rubberduck/releases/download/Prerelease-v2.5.1.5559/Rubberduck.Setup.2.5.1.5559-pre.exe' # download url
$checksum     = 'd8b52305b8fd9d57dbbf3ff69db1d3dde1a3c4645f4c49efdbb21f18ecd06b71'
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
