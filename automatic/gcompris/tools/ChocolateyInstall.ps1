$ErrorActionPreference = 'Stop'
$packageName    = 'gcompris'
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

$packageArgs = @{
  packageName    = $packageName
  fileType       = 'EXE'
  file           = "$toolsDir\gcompris-qt-3.3-win32-gcc.exe"
  file64         = "$toolsDir\gcompris-qt-3.3-win64-gcc.exe"
  silentArgs     = '/S'
  validExitCodes = @(0,1)
  softwareName   = 'GCompris Educational Software'
}
 
Install-ChocolateyInstallPackage @packageArgs
Remove-Item "$toolsDir\*.exe" -EA SilentlyContinue | Out-Null
