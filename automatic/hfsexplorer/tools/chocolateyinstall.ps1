$ErrorActionPreference = 'Stop'
$packageName= 'hfsexplorer'
$toolsDir    = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

$packageArgs = @{
  packageName   = $packageName
  fileType      = 'EXE'
  file          = "$toolsDir\hfsexplorer-"+$env:ChocolateyPackageVersion+"-setup.exe"
  silentArgs    = '/S'
  softwareName  = 'HFSExplorer*'
  }
  
Install-ChocolateyInstallPackage @packageArgs
Remove-Item $toolsDir\*.exe -Force | Out-Null
Remove-Item $toolsDir\*.ignore -Force | Out-Null

# UPDATE INSTRUCTIONS:
# Replace EXE with current version
