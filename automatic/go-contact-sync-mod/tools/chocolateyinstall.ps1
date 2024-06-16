# https://sourceforge.net/projects/googlesyncmod/files/
$ErrorActionPreference = 'Stop'
$toolsDir    = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

$packageArgs = @{
  packageName    = 'go-contact-sync-mod'
  fileType       = 'MSI'
  file           = "$toolsDir\SetupGCSM-$ENV:ChocolateyPackageVersion.msi"
  silentArgs     = '/quiet /qn /norestart'
  softwareName   = 'Go Contact Sync Mod*' 
  validExitCodes = @(0, 3010, 1641)
  }
  
Install-ChocolateyInstallPackage @packageArgs
Remove-Item $toolsDir\*.msi -Force | Out-Null
