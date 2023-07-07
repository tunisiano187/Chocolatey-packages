$ErrorActionPreference = 'Stop';

$url            = 'https://downloads.arduino.cc/arduino-ide/arduino-ide_2.1.1_Windows_64bit.exe'
$checksum       = '18116395a2864e1acd5d81f52bf9d761dd81c1e0644d9c03b8cac973a7f60cc9'
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
