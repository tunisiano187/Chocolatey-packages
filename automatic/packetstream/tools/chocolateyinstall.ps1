$ErrorActionPreference = 'Stop'
$url			      = ''
$checksum		    = ''
$checksumtype   = ''
$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  unzipLocation = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
  fileType      = 'exe'
  url           = $url
  silentArgs    = '/quiet'
  validExitCodes= @(0,3010)
  softwareName  = 'Packetstream*'
  checksum      = $checksum
  checksumType  = $checksumtype
}

Install-ChocolateyPackage @packageArgs
