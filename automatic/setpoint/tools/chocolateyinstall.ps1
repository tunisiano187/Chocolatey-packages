$ErrorActionPreference = 'Stop'; 
$packageName = 'setpoint' 
$url         = 'https://download01.logi.com/web/ftp/pub/techsupport/mouse/SetPoint6.90.66_32.exe'
$checksum    = '06B3C8BEDEC10A246FDFE5E316B86FCE5BD88EA1BE72EB1260F1E7D2C15641CA'
$url64       = 'https://download01.logi.com/web/ftp/pub/techsupport/mouse/SetPoint6.90.66_64.exe'
$checksum64  = 'A28A337C430C5795B10246212FC9E5D5058DBF2A30D4F6BCE7BD2F4062286194'

$packageArgs = @{
  packageName   = $packageName
  fileType      = 'EXE' 
  url           = $url
  checksum      = $checksum
  checksumType  = 'sha256' 
  url64bit      = $url64  
  checksum64    = $checksum64
  checksumType64= 'sha256'  
  silentArgs    = '/S'
  softwareName  = 'Logitech SetPoint*' 
  }
  
Install-ChocolateyPackage @packageArgs
