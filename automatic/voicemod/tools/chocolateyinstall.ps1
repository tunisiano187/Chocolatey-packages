$ErrorActionPreference = 'Stop';
$url          = 'https://www.voicemod.net/b2c/preview/VoicemodSetup_2.38.1.0.exe'
$checksum     = 'e06d3c5466f5cb1305ea2a7507b5185d5ddbfb219b36801f2f300951065be6a3'
$checksumType = 'sha256'

$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  fileType      = 'EXE'
  url           = $url

  softwareName  = 'voicemod*'

  checksum      = $checksum
  checksumType  = $checksumType

  validExitCodes= @(0, 3010, 1641)
  silentArgs   = '/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-' # Inno Setup
}

$scriptPath = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$ahkFile = Join-Path $scriptPath "chocolateyInstall.ahk"
$ahkExe = 'AutoHotKey'
$ahkRun = "$Env:Temp\$(Get-Random).ahk"
Copy-Item $ahkFile "$ahkRun" -Force
Start-Process $ahkExe $ahkRun

Install-ChocolateyPackage @packageArgs
