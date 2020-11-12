
$ErrorActionPreference = 'Stop';
$url            = 'https://github.com/Mobsya/aseba/releases/download/2.1.3/ThymioSuite-2.1.3-win32.exe'
$url64          = 'https://github.com/Mobsya/aseba/releases/download/2.1.3/ThymioSuite-2.1.3-win64.exe'
$checksum       = 'ef960ab65b4548984a6ef3ed5009f4ea2c060b70dfcffd07ddf52933f0f79a0f'
$checksumType   = 'sha256'
$checksum64     = 'ffd4758890daca57c6ccb67017b4baf1178899b8d1e09619ce4cf046afa21a0b'
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
  silentArgs   = '/S'
}

$scriptPath = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$ahkFile = Join-Path $scriptPath "chocolateyInstall.ahk"
$ahkExe = 'AutoHotKey'
$ahkRun = "$Env:Temp\$(Get-Random).ahk"
Copy-Item $ahkFile "$ahkRun" -Force
Start-Process $ahkExe $ahkRun

Install-ChocolateyPackage @packageArgs
