$ErrorActionPreference = 'Stop'
$url			= 'https://www.odrive.com/downloaddesktop?platform=win'
$checksum		= 'd98dd8eb989e2517cc522166ec60b9c98683e38c1cf2cb2dba4de7f3ba361789'
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
