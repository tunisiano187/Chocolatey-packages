$ErrorActionPreference = 'Stop';

$url            = 'https://downloads.arduino.cc/arduino-ide/arduino-ide_2.0.3_Windows_64bit.exe'
$checksum       = '5bcdc4953d7e28065c0a7600f63c58ebfcd6dadf289e43db3fdca3f97930c7f0'
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
