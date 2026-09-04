$ErrorActionPreference = 'Stop'
$packageName    = 'network-inventory-advisor'
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url            = 'https://www.network-inventory-advisor.com/download/network_inventory_advisor.exe'
$checksum       = '564140bddcdbe58b9bfd7680f1745b33ba75318317a6e7a3be086cf79978aa0a'
$checksumType   = 'sha256'

$packageArgs = @{
  packageName    = $packageName
  unzipLocation  = $toolsDir
  fileType       = 'EXE'
  url            = $url
  validExitCodes = @(0, 3010, 1641)
  silentArgs     = '/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-'
  softwareName   = 'Network Inventory Advisor*'
  checksum       = $checksum
  checksumType   = $checksumType
}

Install-ChocolateyPackage @packageArgs
