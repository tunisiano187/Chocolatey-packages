$ErrorActionPreference = 'Stop';

$url            = 'https://bitcoincore.org/bin/bitcoin-core-0.21.1/bitcoin-0.21.1-win64-setup-unsigned.exe'
$checksum       = 'afdd0f1717a74af01b88631d17a2f29f89d21ca2e3be0fec0678e7a1e20712d5'
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

$ahkFile = Join-Path $toolsDir "arduinoInstall.ahk"
Start-Process -FilePath 'AutoHotKey' -ArgumentList $ahkFile

Install-ChocolateyPackage @packageArgs

#Don't need installer anymore
Remove-Item $toolsDir\*.exe -ea 0 -force
