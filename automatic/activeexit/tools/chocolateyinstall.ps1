$packageName   = 'activeexit'
$installerType = 'EXE'
$toolsDir      = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url           = 'https://www.winabilitysoftware.com/files/ActiveExitLite-24.5.0-setup.exe'
$checksumType  = 'sha256'
$checksum      = '4D6FFF49D6FEAA1159A5735337440DF8F2E03A925D9BC38ABC767734018D85D0'
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
