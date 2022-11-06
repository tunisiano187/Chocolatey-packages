$ErrorActionPreference = 'Stop'

$toolsPath = Split-Path $MyInvocation.MyCommand.Definition

$packageArgs = @{
  packageName  = $env:ChocolateyPackageName
  fileType     = 'exe'
  file         = Get-Item $toolsPath\*.exe
  silentArgs    = "/qn /norestart /l*v `"$($env:TEMP)\$($packageName).$($env:chocolateyPackageVersion).MsiInstall.log`"" # ALLUSERS=1 DISABLEDESKTOPSHORTCUT=1 ADDDESKTOPICON=0 ADDSTARTMENU=0
  validExitCodes= @(0, 3010, 1641)
  softwareName = 'Nefarius Virtual Gamepad Emulation Bus Driver*'
}

Install-ChocolateyInstallPackage @packageArgs
Remove-Item $toolsPath\*.exe -ea 0