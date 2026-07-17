$packageName   = 'activeexit'
$installerType = 'EXE'
$toolsDir      = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url           = 'https://www.winabilitysoftware.com/files/ActiveExitLite-26.7.0-setup.exe'
$checksumType  = 'sha256'
$checksum      = 'BEDE2AF9580101C8BFF79A6FC1EBE4129C3F5797001FAB9AEC911A4849E46865'
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
  checksumType  = $checksumType
  silentArgs    = $silentArgs
  validExitCodes= $validExitCodes
}

Install-ChocolateyPackage @packageArgs
