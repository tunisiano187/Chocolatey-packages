$packageName    = 'netstress'
$installerType  = 'exe'
$url            = 'https://nutsaboutnets-downloads.s3.amazonaws.com/NetStress-Setup.exe'
$checksum       = 'A298B42B4C11209E3BD6DB71E1C6E718F2223807A1CFAC6A3640A3735028EA1B'
$silentArgs     = '/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-'
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$validExitCodes = @(0)
$softwareName   = 'NetStress*'

$packageArgs = @{
  packageName   = $packageName
  unzipLocation = $toolsDir  
  fileType      = $installerType
  url           = $url
  validExitCodes= $validExitCodes
  silentArgs    = $silentArgs
  softwareName  = $softwareName
  checksum      = $checksum
  checksumType  = 'sha256' 
}

Install-ChocolateyPackage @packageArgs
