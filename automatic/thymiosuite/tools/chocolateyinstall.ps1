
$ErrorActionPreference = 'Stop';
$url            = 'https://github.com/Mobsya/aseba/releases/download/2.1.5/ThymioSuite-2.1.5-win32.exe'
$url64          = 'https://github.com/Mobsya/aseba/releases/download/2.1.5/ThymioSuite-2.1.5-win64.exe'
$checksum       = '30528c7206fb6a1db435b27d70fe8b0fee3ee5afddba5aaffd231619b5e47dbd'
$checksumType   = 'sha256'
$checksum64     = '99262c72d4eb294dfa4c6c5d0e9e36fd3ef3907264b1cb17068dc7d2eaa36ec2'
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
