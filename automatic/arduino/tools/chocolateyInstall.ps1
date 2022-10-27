$ErrorActionPreference = 'Stop';

$url            = 'https://downloads.arduino.cc/arduino-ide/arduino-ide_2.0.1_Windows_64bit.exe'
$checksum       = 'c445aebe9f6a039d24a83bc5c12c922e28735eede7402b9cf9f69f9dfde630fe'
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
