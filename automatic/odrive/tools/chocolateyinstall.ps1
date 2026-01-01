$ErrorActionPreference = 'Stop'
$url			= 'https://dba0rg1h0v09q.cloudfront.net/odrivesync.7454.exe'
$checksum		= 'a4440dc3613313932466ac81f1c4a2aef588a7c3e686eecadfff5c818ef990fe'
$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  unzipLocation = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
  fileType      = 'exe'
  url           = $url
  silentArgs    = '/quiet'
  validExitCodes= @(0,3010)
  softwareName  = 'odrive*'
  checksum      = $checksum
  checksumType  = 'sha256'
}

Install-ChocolateyPackage @packageArgs
