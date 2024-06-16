$ErrorActionPreference = 'Stop'
$packageName= 'free-pst-reader'
$softwareName = 'Free PST Reader*'
$installerType = 'EXE'
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url        = 'http://ost2pstware.com/dl/free-pst-reader.exe' 
$checksum   = 'D47196DB378B0F2B1F1F781F3274FB8FFA911861C6465BF61DC4FA208FA7E466'
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
  
