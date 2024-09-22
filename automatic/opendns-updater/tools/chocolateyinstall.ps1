$ErrorActionPreference = 'Stop'
$packageName    = 'opendns-updater'
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url            = 'https://s3-us-west-1.amazonaws.com/opendns-downloads/OpenDNS-Updater-2.2.1.exe' 
$checksum       = 'F806B50836914731B1D5A5611B4F497191D097C58A728DD8129B29C7FB66FA25'
$silentArgs     = '/S' 
$validExitCodes = @(0) 

$packageArgs = @{
  packageName   = $packageName
  unzipLocation = $toolsDir
  fileType      = 'EXE' 
  url           = $url
  silentArgs    = $silentArgs 
  validExitCodes= $validExitCodes 
  softwareName  = 'OpenDNS Updater 2.2.1*'
  checksum      = $checksum
  checksumType  = 'sha256'  
}

Install-ChocolateyPackage @packageArgs
