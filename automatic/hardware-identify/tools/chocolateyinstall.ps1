$ErrorActionPreference = 'Stop'
$packageName= 'hardware-identify'
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url        = 'http://www.tweaking.com/files/setups/tweaking.com_hardware_identify_setup.exe' 
$checksum   = '6E593062BB5EA311EDE97DD6381FD7658E12A267991CDFE501D29446B7498ECB'

$packageArgs = @{
  packageName    = $packageName
  fileType       = 'EXE'
  url            = $url
  validExitCodes = @(0)
  silentArgs     = '/S'
  softwareName   = 'Tweaking.com - HardwareIdentify *'
  checksum       = $checksum
  checksumType   = 'sha256' 
}

Install-ChocolateyPackage @packageArgs  
