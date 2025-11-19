$ErrorActionPreference = 'Stop'
$url			= 'https://dba0rg1h0v09q.cloudfront.net/odrivesync.7426.exe'
$checksum		= '19a3ed522d26a23735d762ca2802363d68fec768978a44c21fb617e2f8007acf'
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
