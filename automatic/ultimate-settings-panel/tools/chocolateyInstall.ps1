$ErrorActionPreference = 'Stop'
$packageName    = 'ultimate-settings-panel'
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

$packageArgs = @{
  packageName  = $packageName
  Destination  = "$toolsDir\extracted"
  FileFullPath = "$toolsDir\UltimateSettingsPanel.zip"
}

Get-ChocolateyUnzip @packageArgs

$packageArgs = @{
  packageName    = $packageName
  fileType       = 'EXE'
  file           = "$toolsDir\extracted\setup.exe"
  silentArgs     = '/quiet /qn /norestart'
  validExitCodes = @(0)
  softwareName   = 'Ultimate Settings Panel*'   
}

Install-ChocolateyInstallPackage @packageArgs	

Remove-Item "$toolsDir\extracted" -Recurse -Force -EA SilentlyContinue | Out-Null
Remove-Item "$toolsDir\Ultimate-Settings-Panel.zip" -Force -EA SilentlyContinue | Out-Null

# UPDATE INSTRUCTIONS:
# Every versoin of the ZIP file seems to have different pathing, check it and change this script accordingly.
