$ErrorActionPreference = 'Stop';

$url            = 'https://downloads.arduino.cc/arduino-ide/arduino-ide_2.2.0_Windows_64bit.exe'
$checksum       = '406296408a32954c516d61450bf705b0a58037d32fe7e3a7e29c65d31d3c1dbc'
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
