$ErrorActionPreference = 'Stop'
$packageName    = 'squiggle'
$installerType  = 'msi'
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url            = 'https://github.com/hasankhan/Squiggle/releases/download/3.4.4-beta/Squiggle-3.4.Client.msi' 
$checksum       = 'A9B26DB8C4E310C9E418411D454BFCED955B546EBB2129139EEFC6C41D46A781'
$silentArgs     = "/qn /norestart /l*v `"$($env:TEMP)\$($packageName).$($env:chocolateyPackageVersion).MsiInstall.log`""
$validExitCodes = @(0, 3010, 1641)

$packageArgs = @{
  packageName   = $packageName
  fileType      = $installerType
  url           = $url
  validExitCodes= $validExitCodes
  silentArgs    = $silentArgs
  softwareName  = 'Squiggle*'
  checksum      = $checksum
  checksumType  = 'sha256' 
}

Install-ChocolateyPackage @packageArgs  
  
