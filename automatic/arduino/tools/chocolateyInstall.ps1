$ErrorActionPreference = 'Stop';

$url            = 'https://downloads.arduino.cc/arduino-1.8.15-windows.exe'
$checksum       = ''
$checksumType   = ''
$validExitCodes = @(0)

$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  fileType      = 'EXE'
  Url           = $url
  checksum      = $checksum
  checksumType  = $checksumType
  softwareName  = 'Arduino*'
  silentArgs    = '/S'
  validExitCodes= $validExitCodes
}

$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$ahkFile    = Join-Path $toolsDir "arduinoInstall.ahk"
Start-Process -FilePath 'AutoHotKey' -ArgumentList $ahkFile

Install-ChocolateyPackage @packageArgs

#Don't need installer anymore
Remove-Item $toolsDir\*.exe -ea 0 -force
