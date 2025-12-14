$ErrorActionPreference = 'Stop'
$toolsDir      = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$installer     = (Get-ChildItem -Path $toolsDir -Filter "*.exe").FullName

$packageArgs = @{
  packageName   = 'orangec'
  FileType      = 'EXE'
  File          = $installer
  silentArgs    = '/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-'
  softwareName  = 'Orange C Version*'
}

Install-ChocolateyInstallPackage @packageArgs
Remove-Item $toolsDir\*.exe -Force | Out-Null
Remove-Item $toolsDir\*.ignore -Force | Out-Null
