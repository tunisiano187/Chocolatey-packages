$ErrorActionPreference = 'Stop'
$url			= 'https://www.odrive.com/downloaddesktop?platform=win'
$checksum		= '308a0f2aed3fb460b845c5ab46db1eb73353e21f0bc6468b5b5f22afdcb435f7'
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
