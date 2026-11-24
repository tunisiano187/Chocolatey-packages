$ErrorActionPreference = 'Stop'
$packageName    = 'solarwinds-recovery-console'
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url            = 'https://install.mob.system-monitor.com/backup-and-recovery-rc-windows-x86.exe'
$checksum       = '7A25FF00EA01D93ECD3B74DDFAEDCD22A28D4C071CE72DAC18FE88D6A3BAA769'
$checksumType   = 'sha256'
$url64          = ''
$checksum64     = '6AA8EC34BD11E0E5CB8FCF7F85625A54A7D5529E55421085B19185C87BAC7C0B'
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
