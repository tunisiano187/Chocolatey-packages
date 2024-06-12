$packageName    = 'tonido-drive'
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url            = 'http://patch.codelathe.com/temp/beta/TonidoDriveSetup.exe' 
$checksum       = '46591876EE0DBCF9C6E18B88200154417220A29FD3C9FEAB13C322ECC30D9EDD'
$silentArgs     = '/S' 
$validExitCodes = @(0) 
$ahkExe         = 'AutoHotKey'
$ahkFile        = Join-Path $toolsDir "TDInstall.ahk"

Start-Process $ahkExe $ahkFile

$packageArgs = @{
  packageName   = $packageName
  unzipLocation = $toolsDir
  fileType      = 'EXE' 
  url           = $url
  silentArgs    = $silentArgs  
  validExitCodes= $validExitCodes
  softwareName  = 'TonidoDrive*'
  checksum      = $checksum
  checksumType  = 'sha256'   
}

Install-ChocolateyPackage @packageArgs
