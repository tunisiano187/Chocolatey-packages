$ErrorActionPreference = 'Stop';
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
. "$(Join-Path $toolsDir commonEnv.ps1)"

$checksumType = 'sha256'
$url          = 'https://github.com/sirjuddington/SLADE/releases/download/3.3.0/SLADE_3.3.0_win_x64.7z'
$checksum     = '812e228f25df680921c6ac8bcfee3c335adf381757011edb565aa604817dd951'


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
