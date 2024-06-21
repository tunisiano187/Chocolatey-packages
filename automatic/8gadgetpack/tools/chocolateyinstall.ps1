$ErrorActionPreference = 'Stop'
$packageName    = '8gadgetpack'
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url            = 'https://8gadgetpack.net/dl_370/8GadgetPackSetup.msi'
$checksum       = '821E33CF757BD01BEC6703796C01726E6674B8DE3BC1E7EA834318039E46909E'

$packageArgs = @{
  packageName   = $packageName
  fileType      = 'MSI'
  url           = $url
  validExitCodes= @(0, 3010, 1641)
  silentArgs    = '/quiet /qn /norestart'
  softwareName  = '8GadgetPack'
  checksum      = $checksum
  checksumType  = 'sha256' 
}

Install-ChocolateyPackage @packageArgs  
  
