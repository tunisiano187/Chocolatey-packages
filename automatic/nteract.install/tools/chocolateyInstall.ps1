$ErrorActionPreference = 'Stop';

$packageName  = $env:ChocolateyPackageName
$url          = 'https://github.com/nteract/nteract/releases/download/v2.7.5-stable.202608270405/nteract-stable-windows-x64.exe'
$checksum     = '07043a81824eaa81233f405c868b47fd38cfaa554af7b760f43cb23cde532dae'
$checksumType = 'sha256'

$toolsDir     = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

$packageArgs = @{
  packageName   = $packageName
  unzipLocation = $toolsDir
  fileType      = 'EXE'
  url           = $url

  softwareName  = 'nteract*'

  checksum      = $checksum
  checksumType  = $checksumType

  silentArgs   = '/S' # NSIS
  validExitCodes= @(0, 1, 2)
}

Install-ChocolateyPackage @packageArgs
