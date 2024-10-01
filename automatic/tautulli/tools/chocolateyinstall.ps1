$ErrorActionPreference = 'Stop'
$packageName    = 'tautulli'
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$file            = "$toolsDir\Tautulli-windows-v"+$ENV:ChocolateyPackageVersion+"-x64.exe"

$packageArgs = @{
  packageName  = $packageName
  fileType     = 'EXE'
  file         = $file
  silentArgs   = '/S'
  softwareName = "tautulli"
}

Install-ChocolateyInstallPackage @packageArgs
Remove-Item $file -Force -ErrorAction SilentlyContinue | Out-Null