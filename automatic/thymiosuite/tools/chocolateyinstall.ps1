
$ErrorActionPreference = 'Stop';
$url            = 'https://github.com/Mobsya/aseba/releases/download/2.3.1/ThymioSuite-2.3.1-win32.exe'
$url64          = 'https://github.com/Mobsya/aseba/releases/download/2.3.1/ThymioSuite-2.3.1-win64.exe'
$checksum       = '274aa082d4c250a0d91eaa2f542a589ec25d8d34e90abf603d8407cc3a4709cf'
$checksumType   = 'sha256'
$checksum64     = 'f418b9daf02e653148a43882cff10b34ee1a67aa30b243c9532289dbebd82361'
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
