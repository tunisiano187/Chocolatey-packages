
$ErrorActionPreference = 'Stop';
$url            = 'https://github.com/Mobsya/aseba/releases/download/2.1.4/ThymioSuite-2.1.4-win32.exe'
$url64          = 'https://github.com/Mobsya/aseba/releases/download/2.1.4/ThymioSuite-2.1.4-win64.exe'
$checksum       = '0ad1b241c68e00b08402f0b84d8c86673c89fb0effb1e688a9320e2fa99fe3af'
$checksumType   = 'sha256'
$checksum64     = 'f69720b282c7aff431a5948abfc3f6179a0f3f2ac231c34a30259ba3cc3118b6'
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

$scriptPath = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$ahkFile = Join-Path $scriptPath "chocolateyInstall.ahk"
$ahkExe = '$env:ChocolateyInstall\bin\AutoHotKey.exe'
$ahkRun = "$Env:Temp\$(Get-Random).ahk"
Copy-Item $ahkFile "$ahkRun" -Force
Start-Process $ahkExe $ahkRun

Install-ChocolateyPackage @packageArgs
