$ErrorActionPreference = 'Stop'
$packageName= 'free-ost-reader'
$softwareName = 'Free OST Reader*'
$installerType = 'EXE'
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url        = 'http://ost2pstware.com/dl/free-ost-reader.exe' 
$checksum   = '02038176EAB1C2B09A9528564489D126C7C7FBF7E15BC1930AF5E2DC083659F5'
$silentArgs = '/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-'
$validExitCodes= @(0, 3010, 1641)

$packageArgs = @{
  packageName   = $packageName
  fileType      = $installerType
  url           = $url
  validExitCodes= $validExitCodes
  silentArgs    = $silentArgs
  softwareName  = $softwareName
  checksum      = $checksum
  checksumType  = 'sha256' 
}

Install-ChocolateyPackage @packageArgs  
  
