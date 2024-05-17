$ErrorActionPreference = 'Stop'
$toolsDir       = $(Split-Path -parent $MyInvocation.MyCommand.Definition)
$packageName    = 'wordweb-free'
$url            = "$toolsDir\wordweb10.exe"

$packageArgs = @{
  packageName    = $packageName
  fileType       = 'EXE'
  file           = $url
  validExitCodes = @(0)
  silentArgs     = '-s1'
  softwareName   = 'WordWeb'
  }
  
Install-ChocolateyInstallPackage @packageArgs
Remove-Item $toolsDir\*.exe -force | Out-Null
Remove-Item $toolsDir\*.ignore -force | Out-Null

# UPDATE INSTRUCTIONS:
# Update the binary with the latest version

