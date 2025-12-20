$ErrorActionPreference = 'Stop';
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
. "$(Join-Path $toolsDir commonEnv.ps1)"

$checksumType = ''
$url          = 'https://slade.mancubus.net/files/3.2.4/slade_3.2.4_x64.7z'
$checksum     = '06B3C8BEDEC10A246FDFE5E316B86FCE5BD88EA1BE72EB1260F1E7D2C15641CA'


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
