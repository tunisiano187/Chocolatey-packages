$ErrorActionPreference = 'Stop'
$packageName   = 'metafox'
$toolsDir      = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$TodaysVersion = $env:ChocolateyPackageVersion -replace '[.]',''

$packageArgs = @{
  packageName    = $packageName
  softwareName   = 'MetaFox*'  
  fileType       = 'EXE'
  silentArgs     = '/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-'  
  file           = "$toolsDir\MetaFox_"+$TodaysVersion+".exe"
  validExitCodes = @(0)  
  }
  
Install-ChocolateyInstallPackage @packageArgs
Remove-Item "$toolsDir\*.exe" -EA SilentlyContinue | Out-Null
