$ErrorActionPreference = 'Stop'
$toolsDir    = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url         = 'https://allwaysync.com/content/download/allwaysync.exe'
$checksum    = 'EFD10324D81669FA47ECE5CA98D1C043C4717CB81E97BEF926C21C110532A0F2'
$url64       = 'https://allwaysync.com/content/download/allwaysync-x64.exe'
$checksum64  = '6A2B489E07964975B666CC82492DF21EE9A5DB51B4827E39D0694F6FCAF08D89'

$packageArgs = @{
  packageName    = 'allway-sync'
  fileType       = 'exe' 
  url            = $url
  checksum       = $checksum
  checksumType   = 'sha256'  
  url64bit       = $url64
  checksum64     = $checksum64
  checksumType64 = 'sha256'
  silentArgs     = '/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-' 
  softwareName   = 'Allway Sync*' 
  }
  
Install-ChocolateyPackage @packageArgs
