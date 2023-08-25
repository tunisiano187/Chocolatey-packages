$ErrorActionPreference = 'Stop'
$packageName    = $env:ChocolateyPackageName
$installerType  = 'EXE'
$silentArgs     = '/qb'
$url            = 'https://www.filejuggler.com/download/filejuggler.exe'
$checksum       = 'ebffeaadfb35bf170cbc304e77452afc6d066fbad2aebe9ca8efa0cec4106101'
$checksumtype	= 'sha256'

$scriptPath     = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$ahkFile        = Join-Path $scriptPath "chocolateyInstall.ahk"
$ahkExe         = 'AutoHotKey'
$ahkRun         = "$Env:Temp\$(Get-Random).ahk"

Copy-Item $ahkFile "$ahkRun" -Force
Start-Process $ahkExe $ahkRun

Install-ChocolateyPackage $packageName $installerType $silentArgs $url -checksum $checksum -ValidExitCodes @(0,1223) -ChecksumType $checksumtype
