$ErrorActionPreference = 'Stop';
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url64          = 'https://download.live.ledger.com/ledger-live-desktop-2.77.2-win-x64.exe'
$checksum64     = '35F340163F9059F61608B57E75CC39A7C8FAAEB51DBEF510AB6FC85246C397FD'
$checksumType64 = 'sha256'

$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  unzipLocation = $toolsDir
  fileType      = 'EXE'
  url64bit      = $url64
  softwareName  = 'ledger-live*'
  checksum64    = $checksum64
  checksumType64= $checksumType64
  silentArgs   = '/S'
}

Install-ChocolateyPackage @packageArgs

