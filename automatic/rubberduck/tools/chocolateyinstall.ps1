$ErrorActionPreference = 'Stop';

$packageName  = $env:ChocolateyPackageName
$toolsDir     = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url          = 'https://github.com/rubberduck-vba/Rubberduck/releases/download/Prerelease-v2.5.1.5701/Rubberduck.Setup.2.5.1.5701-pre.exe' # download url
$checksum     = 'b4b743cbdab162cc24c4ac312dba4dfc5a8179befb5fb24a3108c35c3a1177c0'
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
