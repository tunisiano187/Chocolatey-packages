$ErrorActionPreference = 'Stop'
$packageName    = 'solarwinds-automation-manager'
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url            = "https://rm-downloads-us.logicnow.com/automation-manager/AutomationManager-$env:ChocolateyPackageVersion.exe"
$checksum       = 'A08C8A29EF6ECCDED7C7FF8C263FEFA0216F0FFA0D14DDC20179AB081F596AE9'

$packageArgs = @{
  packageName   = $packageName
  fileType      = 'EXE'
  url           = $url
  validExitCodes= @(0,1)
  silentArgs    = '/S'
  softwareName  = 'Automation Manager*'
  checksum      = $checksum
  checksumType  = 'sha256' 
}

Install-ChocolateyPackage @packageArgs

