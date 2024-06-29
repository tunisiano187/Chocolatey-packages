$ErrorActionPreference = 'Stop'
$toolsDir    = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

$packageArgs = @{
  packageName    = 'osfmount'
  fileType       = 'EXE'
  silentArgs     = '/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-' 
  softwareName   = 'OSFMount*' 
  file           = "$toolsDir\osfmount.exe"
  validExitCodes = @(0, 3010, 1641)
}
  
Install-ChocolateyInstallPackage @packageArgs
Start-CheckandStop 'OSFMount'  
