$ErrorActionPreference = 'Stop'
$packageName    = 'resilio-sync-business'
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url            = 'https://download-cdn.resilio.com/stable/windows/cc/2501/Resilio-Sync.exe'
$checksum       = '3E3D9BC73EC6F33B5002E2B4D96E7F4CC2B3E4081AE7A9F63A4EFD7C85008240'
$url64          = 'https://download-cdn.resilio.com/stable/windows64/cc/2501/Resilio-Sync_x64.exe'
$checksum64     = '56EB5832A5155D265653AAEF92354F5CDCFAE98F9E8A721F595265C5953E9530'

$packageArgs = @{
  packageName    = $packageName
  fileType       = 'EXE'
  url            = $url
  url64          = $url64
  validExitCodes = @(0, 1)
  silentArgs     = '/S'
  softwareName   = 'Resilio Sync'
  checksum       = $checksum
  checksum64     = $checksum64
  checksumType   = 'sha256' 
  checksumType64 = 'sha256' 
}

Start-CheckandStop "Resilio Sync"
Install-ChocolateyPackage @packageArgs
Start-Sleep -s 5
if ($ProcessWasRunning -eq $False) {Start-CheckandStop "Resilio Sync"}
