$packageName    = 'visualbasic6-kb896559'
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$ahkExe         = 'AutoHotKey'
$ahkFile        = "$toolsDir\visualbasic6-kb896559_install.ahk"
$url            = 'https://download.microsoft.com/download/3/a/5/3a5925ac-e779-4b1c-bb01-af67dc2f96fc/VisualBasic6-KB896559-v1-ENU.exe'
$checksum       = '32857E7B99254630F292B8F268FD60FEB128B5DC5BD7E50F4C2C6BAA5EA04EB3'

$packageArgs = @{
  packageName   = $packageName
  unzipLocation = $toolsDir  
  fileType      = 'EXE'
  url           = $url
  validExitCodes= @(0,1, 3010)
  silentArgs    = '/Q'
  softwareName  = ''
  checksum      = $checksum
  checksumType  = 'sha256'
}

Start-Process $ahkExe $ahkFile  
Install-ChocolateyPackage @packageArgs
