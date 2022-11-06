
$ErrorActionPreference = 'Stop';
$url            = 'https://github.com/Mobsya/aseba/releases/download/2.3.2/ThymioSuite-2.3.2-win32.exe'
$url64          = 'https://github.com/Mobsya/aseba/releases/download/2.3.2/ThymioSuite-2.3.2-win64.exe'
$checksum       = '9658bb05a755c0eda8f4286ffe435da4daa19f7c71b13143a99adb5bce855022'
$checksumType   = 'sha256'
$checksum64     = 'd8122a0670d8fcc140320a8ee6bbf50965baeb4c6755dd03ce5675f3e9f1daac'
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
