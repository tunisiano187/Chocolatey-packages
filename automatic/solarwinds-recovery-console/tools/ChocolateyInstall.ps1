$ErrorActionPreference = 'Stop'
$packageName    = 'solarwinds-recovery-console'
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url            = 'https://install.mob.system-monitor.com/backup-and-recovery-rc-windows-x86.exe'
$checksum       = 'A5687B01ADA98623EABF01B63F858769AA77AC1BE4B63F2FEE728C7104973E7C'
$url64          = 'https://install.mob.system-monitor.com/backup-and-recovery-rc-windows-x64.exe'
$checksum64     = '138E1C519B9018FF9B36A6D47A9014571AB7D8C46AA54F5568612318A6670383'

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
  checksumType   = 'sha256'
  checksumType64 = 'sha256'
}

Install-ChocolateyPackage @packageArgs

Start-CheckandStop "ProcessController"
Start-CheckandStop "RecoveryConsole"
