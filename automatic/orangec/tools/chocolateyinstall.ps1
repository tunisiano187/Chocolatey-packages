$ErrorActionPreference = 'Stop'
$toolsDir      = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$TodaysVersion = ($ENV:ChocolateyPackageVersion -replace '[.]','')
$installer     = "$toolsDir\occ"+$TodaysVersion+".exe"

$packageArgs = @{
  packageName   = 'orangec'
  fileType      = 'EXE'
  file          = $installer
  silentArgs    = '/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-'
  softwareName  = 'Orange C Version*' 
  }
  
Install-ChocolateyInstallPackage @packageArgs
Remove-Item $toolsDir\*.exe -Force | Out-Null
Remove-Item $toolsDir\*.ignore -Force | Out-Null
