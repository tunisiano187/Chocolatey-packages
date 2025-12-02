$ErrorActionPreference = 'Stop'
$url			= 'https://dba0rg1h0v09q.cloudfront.net/odrivesync.7434.exe'
$checksum		= 'b9bf273b3e8d0c031a70570ae090cdce986fd77c1fea03f9304ff0fe14887a64'
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
