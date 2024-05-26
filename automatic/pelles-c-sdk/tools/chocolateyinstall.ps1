$packageName    = 'pelles-c-sdk'
$installerType  = 'EXE'
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url            = 'http://www.smorgasbordet.com/pellesc/800/setupsdk.exe' 
$checksum       = 'FED93A7A1C7F0AB01553D822E11E339A66B6EE6815C8DBCA3A50A0452C6002B8'
$url64          = 'http://www.smorgasbordet.com/pellesc/800/setupsdk64.exe' 
$checksum64     = '7AD688E6072C25893B2265800BF4898053F862F2A642E7DF0666DC2E8DE1CB98'
$silentArgs     = ''
$validExitCodes = @(0)
$ahkExe         = 'AutoHotKey'
$ahkFile        = Join-Path $toolsDir "PellesCSDKInstall.ahk"
	
Start-Process $ahkExe $ahkFile

$packageArgs = @{
  packageName   = $packageName
  fileType      = 'EXE' 
  url           = $url
  url64         = $url64  
  softwareName  = 'Pelles C Add-In SDK' 
  checksum      = $checksum
  checksum64    = $checksum64  
  checksumType  = 'sha256'
  silentArgs    = $silentArgs
  validExitCodes= $validExitCodes
}

Install-ChocolateyPackage @packageArgs 
