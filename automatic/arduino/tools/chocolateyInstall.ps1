$ErrorActionPreference = 'Stop';

$url            = 'https://downloads.arduino.cc/arduino-ide/arduino-ide_2.1.0_Windows_64bit.exe'
$checksum       = '410a21a64e111f7cee6dfda34696a5e62a7d2d86d8bd45a6476da01981d550b4'
$checksumType   = 'sha256'
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

Install-ChocolateyPackage @packageArgs

#Don't need installer anymore
Remove-Item $toolsDir\*.exe -ea 0 -force
