
$ErrorActionPreference = 'Stop';
$url            = 'https://github.com/Mobsya/aseba/releases/download/2.4.0/ThymioSuite-2.4.0-win32.exe'
$url64          = 'https://github.com/Mobsya/aseba/releases/download/2.4.0/ThymioSuite-2.4.0-win64.exe'
$checksum       = '92cd45818134197dcf7ada0f47b0e976f86e105d59b3ce7600eff0adce25d033'
$checksumType   = 'sha256'
$checksum64     = 'f5aff9c5cb89f45bf74e976868e873f2cd1ecff6fc5a64c29c14f38f93d33379'
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
