$packageName = $env:ChocolateyPackageName
$installerType  = 'EXE'
$url32          = 'http://wampserver.aviatechno.net/files/install/wampserver3.2.0_x86.exe'
$url64          = 'http://wampserver.aviatechno.net/files/install/wampserver3.2.0_x64.exe'
$checksumType   = 'sha256'
$checksum64type = 'sha256'
$checksum32     = ''
$checksum64     = ''

$silentArgs = ''
$validExitCodes = @(0)

$packageArgs = @{
  packageName   = $packageName
  fileType      = $installerType
  url           = $url32
  url64			    = $url64
  silentArgs    = $silentArgs
  validExitCodes= $validExitCodes
  softwareName  = 'wamp-server*'
  checksum      = $checksum32
  checksum64    = $checksum64
  checksumType  = $checksumtype
  checksum64Type= $checksum64type
}

if(Get-ProcessorBits -compare 64) {
  $installahk   = 'chocolateyInstall64.ahk'
} else {
  $installahk   = 'chocolateyInstall.ahk'
}

$scriptPath = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$ahkFile = Join-Path $scriptPath $installahk
$ahkExe = 'AutoHotKey'
$ahkRun = "$Env:Temp\$(Get-Random).ahk"
Copy-Item $ahkFile "$ahkRun" -Force
Start-Process $ahkExe $ahkRun

$scriptPath = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$ahkFile = Join-Path $scriptPath "chocolateyLang.ahk"
$ahkExe = 'AutoHotKey'
$ahkRun = "$Env:Temp\$(Get-Random).ahk"
Copy-Item $ahkFile "$ahkRun" -Force
Start-Process $ahkExe $ahkRun

Install-ChocolateyPackage @packageArgs
