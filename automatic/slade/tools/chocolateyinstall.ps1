$ErrorActionPreference = 'Stop';
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
. "$(Join-Path $toolsDir commonEnv.ps1)"

$checksumType = 'sha256'
$url          = 'https://slade.mancubus.net/files/3.2.12/slade_3.2.12_x64.7z'
$checksum     = '95dbaab79f317e8191861642a7b438266eaa227e3528399af01e184048e2974b'


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
