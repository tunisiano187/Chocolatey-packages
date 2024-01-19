$ErrorActionPreference = 'Stop'
$url			= 'https://www.odrive.com/downloaddesktop?platform=win'
$checksum		= '196056931b738778aee22d680206b7b9b91b12f02136bd02d31da99bd6505555'
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
