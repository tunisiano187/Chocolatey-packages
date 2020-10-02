
$ErrorActionPreference = 'Stop';
$url            = 'https://github.com/Mobsya/aseba/releases/download/2.1.1/ThymioSuite-2.1.1-win32.exe'
$url64          = 'https://github.com/Mobsya/aseba/releases/download/2.1.1/ThymioSuite-2.1.1-win64.exe'
$checksum       = '0d00a432cd0efa1dd06d96c3114a3b33883f1cb846f3c3ed527b581704b594fb'
$checksumType   = 'sha256'
$checksum64     = 'cad8d5e02db5b014c13fb10a99728f32ba143b005030a938622fc33c39739a79'
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
