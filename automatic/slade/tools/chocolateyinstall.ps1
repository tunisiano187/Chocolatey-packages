$ErrorActionPreference = 'Stop';
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
. "$(Join-Path $toolsDir commonEnv.ps1)"

$unzipLocation = $installLocation
$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  unzipLocation = $unzipLocation
  url           = 'https://slade.mancubus.net/files/3.2.4/slade_3.2.4_x64.7z'
  checksum      = 'bcfab589ea979c993ea66d5f4070918fee0f46a8183308b62b7db153b95374cc'
  checksumType  = 'sha256'
}
Install-ChocolateyZipPackage @packageArgs

## StartMenu
Install-ChocolateyShortcut "$(Join-Path $startMenuDir $appName).lnk" `
  -TargetPath $binLocation `
  -WorkingDirectory "$installLocation"
