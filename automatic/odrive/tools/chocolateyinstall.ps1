$ErrorActionPreference = 'Stop'
$url			= 'https://dba0rg1h0v09q.cloudfront.net/odrivesync.7322.exe'
$checksum		= '68f22f7bfe9a7c35d2a8e9a7f07c633fdbdc5e893bbc5a4d3dfdb785065ddd55'
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
