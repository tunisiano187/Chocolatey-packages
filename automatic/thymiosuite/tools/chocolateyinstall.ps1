
$ErrorActionPreference = 'Stop';
$url            = 'https://github.com/Mobsya/aseba/releases/download/2.2.0-beta/ThymioSuite-2.2.0-win32.exe'
$url64          = 'https://github.com/Mobsya/aseba/releases/download/2.2.0-beta/ThymioSuite-2.2.0-win64.exe'
$checksum       = '163a056c8cffa1252cf4e6e8a75844c4b1acffc8b86675bff4425a0c511aabdd'
$checksumType   = 'sha256'
$checksum64     = 'cdc9a2688fc125e01d2cf3830eb7a5b5e87d06ea08655b6891c8ac29bdee0ad8'
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
