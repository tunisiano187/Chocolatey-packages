$ErrorActionPreference = 'Stop'
$url			= 'https://www.odrive.com/downloaddesktop?platform=win'
$checksum		= 'b01ce49e13373b7d93063b00c9cf7344da671b455d1763837574276f3a55cc08'
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
