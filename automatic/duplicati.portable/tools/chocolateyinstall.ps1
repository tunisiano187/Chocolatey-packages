$ErrorActionPreference = 'Stop'
$packageName    = $env:ChocolateyPackageName
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url            = 'https://github.com/duplicati/duplicati/releases/download/v2.1.2.1_beta_2025-10-03/duplicati-2.1.2.1_beta_2025-10-03-win-x64-gui.zip'
$checksum       = '9adfc539acbde86e2fd0c7e5a316a0899fb17cfd4b0a13c34c10db38878a8d9e'
$checksumType   = 'sha256'


$packageArgs = @{
  packageName   = $packageName
  unzipLocation = $toolsDir
  fileType      = 'ZIP'
  url           = $url
  checksum      = $checksum
  checksumType  = $checksumType
}

Install-ChocolateyZipPackage @packageArgs
