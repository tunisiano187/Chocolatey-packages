$ErrorActionPreference = 'Stop'
$packageName    = $env:chocolateyPackageName
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url            = "$toolsDir\Tautulli-windows-v"+$ENV:ChocolateyPackageVersion+"-x64.exe"
$checksum       = 'D41D8CD98F00B204E9800998ECF8427E'
$checksumType   = 'MD5'

$packageArgs = @{
  packageName  = $packageName
  fileType     = 'EXE'
  url          = $url
  checksum     = $checksum
  checksumType = $checksumType
  silentArgs   = '/S'
  softwareName = "tautulli"
}

Install-ChocolateyPackage @packageArgs