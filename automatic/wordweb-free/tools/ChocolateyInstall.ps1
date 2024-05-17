$ErrorActionPreference = 'Stop'
$toolsDir       = $(Split-Path -parent $MyInvocation.MyCommand.Definition)
$packageName    = 'wordweb-free'
$file            = (Get-ChildItem -Path $toolsDir -Filter "*.exe")

$packageArgs = @{
  packageName    = $packageName
  fileType       = 'EXE'
  file           = $file
  validExitCodes = @(0)
  silentArgs     = '-s1'
  softwareName   = 'WordWeb'
  }
  
Install-ChocolateyInstallPackage @packageArgs
Remove-Item $toolsDir\*.exe -force | Out-Null
Remove-Item $toolsDir\*.ignore -force | Out-Null

# UPDATE INSTRUCTIONS:
# Update the binary with the latest version

