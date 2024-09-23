$ErrorActionPreference = 'Stop'
$packageName    = 'ost2' 
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url            = 'http://d.4team.biz/files/ost2_setup.exe'
$checksum       = '07BBADB855D3B8DF3D614388F6F5D9A4FA87DE885937EE99C909868298D177FA'
$ahkExe         = 'AutoHotKey'
$ahkFile        = "$toolsDir\OST2install.ahk"

Start-Process $ahkExe $ahkFile

$packageArgs = @{
  packageName    = $packageName
  unzipLocation  = $toolsDir
  fileType       = 'exe' 
  url            = $url
  checksum       = $checksum
  checksumType   = 'sha256'  
  silentArgs     = '/S'
  validExitCodes = @(0,2)
  softwareName   = 'OST2*' 
  }
  
Install-ChocolateyPackage @packageArgs
