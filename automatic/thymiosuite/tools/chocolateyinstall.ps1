
$ErrorActionPreference = 'Stop';
$url            = 'https://github.com/Mobsya/aseba/releases/download/2.3.0/ThymioSuite-2.3.0-win32.exe'
$url64          = 'https://github.com/Mobsya/aseba/releases/download/2.3.0/ThymioSuite-2.3.0-win64.exe'
$checksum       = '6d0f3fb5a3e64b4154099f84d6ec4263271eb774874fc0ad2a7b799a9d6661ee'
$checksumType   = 'sha256'
$checksum64     = '86a8ccbf6181be132f7a92cf6ec1377a3e70db2a14308ddfaeb0cbcd4fb5d8d8'
$checksumType64 = 'sha256'

$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  fileType      = 'EXE'
  url           = $url
  url64bit      = $url64

  softwareName  = 'thymiosuite*'

  checksum      = $checksum
  checksumType  = $checksumType
  checksum64    = $checksum64
  checksumType64= $checksumType64

  validExitCodes= @(0, 3010, 1641)
  silentArgs   = '/S /SkipDotNetInstall'
}

$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$ahkFile = Join-Path $toolsDir "chocolateyInstall.ahk"
$ahkExe = 'AutoHotKey.exe'
$ahkRun = "$Env:Temp\$(Get-Random).ahk"
Copy-Item $ahkFile "$ahkRun" -Force
Start-Process $ahkExe $ahkRun

Install-ChocolateyPackage @packageArgs
