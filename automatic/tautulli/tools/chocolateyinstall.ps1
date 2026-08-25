$ErrorActionPreference = 'Stop'
$packageName    = $env:chocolateyPackageName
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url            = 'https://github.com/Tautulli/Tautulli/releases/download/v2.18.0/Tautulli-windows-v2.18.0-x64.exe'
$checksum       = '686de90599ce45c75b1d6dcfa77b2fe2b0a58ae40c14fa966179700f93d72599'
$checksumType   = 'sha256'

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
