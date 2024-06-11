$ErrorActionPreference = 'Stop'
$packageName    = 'network-inventory-advisor'
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url            = 'http://dl.network-inventory-advisor.com/network_inventory_advisor.exe'
$checksum       = '3493772963AB178185996176A1557E9527EDFE0201887F281414D063C723450E'

$packageArgs = @{
  packageName    = $packageName
  unzipLocation  = $toolsDir
  fileType       = 'EXE'
  url            = $url
  validExitCodes = @(0, 3010, 1641)
  silentArgs     = '/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-'
  softwareName   = 'Network Inventory Advisor*'
  checksum       = $checksum
  checksumType   = 'sha256'   
}

Install-ChocolateyPackage @packageArgs
