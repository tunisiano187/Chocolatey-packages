$ErrorActionPreference = 'Stop';
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
. "$(Join-Path $toolsDir commonEnv.ps1)"

$checksumType = 'sha256'
$url          = 'https://slade.mancubus.net/files/3.2.11/slade_3.2.11_x64.7z'
$checksum     = '69cf7c641cd2f587c58c5835773a4ee5d31137e04fb2a74256682f99c93ee538'


$unzipLocation = $installLocation
$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  unzipLocation = $unzipLocation
  url           = $url
  checksum      = $checksum
  checksumType  = $checksumType
}
Install-ChocolateyZipPackage @packageArgs

## StartMenu
Install-ChocolateyShortcut "$(Join-Path $startMenuDir $appName).lnk" `
  -TargetPath $binLocation `
  -WorkingDirectory "$installLocation"
