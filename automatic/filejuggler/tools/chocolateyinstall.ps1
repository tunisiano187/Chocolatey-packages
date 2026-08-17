$ErrorActionPreference = 'Stop'
$packageName    = $env:ChocolateyPackageName
$installerType  = 'EXE'
$silentArgs     = '/qb'
$url            = 'https://www.filejuggler.com/download/filejuggler.exe'
$checksum       = '55388A04FDF030BE1BE34963754CCF0CD31F64309409CB873CC0E9FBECEBEC67'
$checksumtype	= 'sha256'

$scriptPath     = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$ahkFile        = Join-Path $scriptPath "chocolateyInstall.ahk"
$ahkExe         = 'AutoHotKey'
$ahkRun         = "$Env:Temp\$(Get-Random).ahk"

Copy-Item $ahkFile "$ahkRun" -Force
Start-Process $ahkExe $ahkRun

Install-ChocolateyPackage $packageName $installerType $silentArgs $url -checksum $checksum -ValidExitCodes @(0,1223) -ChecksumType $checksumtype
