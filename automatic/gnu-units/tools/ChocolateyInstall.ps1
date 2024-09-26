$ErrorActionPreference = 'Stop'
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$packageName    = 'gnu-units'
$file           = Join-Path $toolsDir 'units-setup.exe'

$packageArgs = @{
  packageName    = $packageName
  fileType       = 'EXE'
  file           = $file
  validExitCodes = @(0)
  silentArgs     = '/VERYSILENT /NOCANCEL /CLOSEAPPLICATIONS /RESTART APPLICATIONS /NORESTART'
  softwareName   = 'units version 2.*'
}

Install-ChocolateyInstallPackage @packageArgs

Remove-Item $toolsDir\*.exe -EA SilentlyContinue | Out-Null
Remove-Item $toolsDir\*.sig -EA SilentlyContinue | Out-Null

# UPDATE INSTRUCTIONS
# Replace EXE and SIG files
