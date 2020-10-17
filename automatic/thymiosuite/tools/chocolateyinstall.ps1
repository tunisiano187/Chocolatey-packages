
$ErrorActionPreference = 'Stop';
$url            = 'https://github.com/Mobsya/aseba/releases/download/2.1.2/ThymioSuite-2.1.2-win32.exe'
$url64          = 'https://github.com/Mobsya/aseba/releases/download/2.1.2/ThymioSuite-2.1.2-win64.exe'
$checksum       = '81e6883473e076d1e3b7733a0d33e35f4ece64f02012059852aec3847b736495'
$checksumType   = 'sha256'
$checksum64     = 'db3cc0e6462a71d22a01434cc6069e953635655925fe034612f06a97bd056399'
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
