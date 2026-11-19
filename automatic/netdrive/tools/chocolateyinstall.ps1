$ErrorActionPreference = 'Stop'
$packageName    = 'netdrive'
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url            = 'https://downloads.bdrive.com/netdrive/builds/62aa8c44213b464f90e770dda560db49/NetDrive3-4.0.42.msi'
$checksum       = '05EE03A265AE0D3A228B242E70B8D0DE49B3BBDF3F57D0017A90F051348061C4'
$checksumType   = 'sha256'

$packageArgs = @{
  packageName    = $packageName
  fileType       = 'MSI'
  url            = $url
  validExitCodes = @(0, 3010, 1641)
  silentArgs     = '/quiet /qn /norestart REINSTALL=ALL REINSTALLMODE=vamus'
  softwareName   = ''
  checksum       = $checksum
  checksumType   = $checksumType
}

Install-ChocolateyPackage @packageArgs
