$ErrorActionPreference = 'Stop'
$packageName   = 'snort' 
$toolsDir      = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$TodaysVersion = ($ENV:ChocolateyPackageVersion -replace '[.]','_')
$url           = "$toolsDir\Snort_Installer.exe"
$ahkExe        = 'AutoHotKey'
$ahkFile       = "$toolsDir\snort_install.ahk"

$packageArgs = @{
  packageName  = $packageName
  fileType     = 'EXE'
  file         = $url
  silentArgs   = '/S'
  softwareName = "Snort"
  }

Start-Process $ahkExe $ahkFile
Install-ChocolateyInstallPackage @packageArgs
Remove-Item $url -Force -ErrorAction SilentlyContinue | Out-Null
