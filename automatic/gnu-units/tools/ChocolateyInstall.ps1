$ErrorActionPreference = 'Stop'
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$packageName    = 'gnu-units'

$packageArgs = @{
  packageName    = $packageName
  fileType       = 'EXE'
  file           = "$toolsDir\units-2.22-setup.exe"
  validExitCodes = @(0)
  silentArgs     = '/VERYSILENT /NOCANCEL /CLOSEAPPLICATIONS /RESTART APPLICATIONS /NORESTART'
  softwareName   = 'units version 2.*'
}

Install-ChocolateyInstallPackage @packageArgs

Remove-Item $toolsDir\*.exe -EA SilentlyContinue | Out-Null
Remove-Item $toolsDir\*.sig -EA SilentlyContinue | Out-Null

# UPDATE INSTRUCTIONS
# Replace EXE and SIG files
