$ErrorActionPreference = 'Stop'
$packageName    = 'solarwinds-recovery-console'
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url            = 'https://install.mob.system-monitor.com/backup-and-recovery-rc-windows-x86.exe'
$checksum       = 'B4B87E3081CBDFBB3AECDB874F1894CD6F5110BD1E8802D0EDF87F6A03A35CED'
$checksumType   = 'sha256'
$url64          = ''
$checksum64     = '8D523DFAC3DE2737AC00307A97FD9EDC94134B6D79B4FA16E70002231B66D2E4'
$checksumType64 = ''

$packageArgs = @{
  packageName    = $packageName
  fileType       = 'EXE'
  url            = $url
  url64          = $url64
  validExitCodes = @(0,1)
  silentArgs     = '/S'
  softwareName   = 'Recovery Console'
  checksum       = $checksum
  checksum64     = $checksum64
  checksumType   = $checksumType
  checksumType64 = $checksumType64
}

Install-ChocolateyPackage @packageArgs

Start-CheckandStop "ProcessController"
Start-CheckandStop "RecoveryConsole"
