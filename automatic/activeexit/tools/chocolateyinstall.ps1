$packageName   = 'activeexit'
$installerType = 'EXE'
$toolsDir      = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url           = 'http://www.winability.com/files/ActiveExitLite-17.3.0-setup.exe' 
$checksum      = '2A12FCC744857DA856B152FF72B3354D9832B6F5502FEE947EBCE07B3F8492E9'
$silentArgs    = ''
$validExitCodes= @(0)
$ahkExe        = 'AutoHotKey'
$ahkFile       = Join-Path $toolsDir "ActiveExitInstall.ahk"

Start-Process $ahkExe $ahkFile

$packageArgs = @{
  packageName   = $packageName
  fileType      = 'EXE' 
  url           = $url
  softwareName  = 'ActiveExit*' 
  checksum      = $checksum
  checksumType  = 'sha256'
  silentArgs    = $silentArgs
  validExitCodes= $validExitCodes
}

Install-ChocolateyPackage @packageArgs 
