$ErrorActionPreference = 'Stop'
$url			= 'https://www.odrive.com/downloaddesktop?platform=win'
$checksum		= '3bc08e0d4187d6f12e410025b32faf991ed92846f82d10e42507101b8d218095'
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
