$ErrorActionPreference = 'Stop'
$packageName= 'logitech-media-server' 
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url        = 'http://downloads.slimdevices.com/LogitechMediaServer_v7.9.3/LogitechMediaServer-7.9.3.exe' 
$checksum   = '40C9733781F2667EACACBB5A06B93553A29F2B630B34E4FBD8CC393083122A4D'

$packageArgs = @{
  packageName   = $packageName
  fileType      = 'EXE' 
  url           = $url
  silentArgs    = '/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-' 
  validExitCodes= @(0) 
  softwareName  = 'Logitech Media Server*' 
  checksum      = $checksum
  checksumType  = 'sha256' 
}

Install-ChocolateyPackage @packageArgs
