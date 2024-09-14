$ErrorActionPreference = 'Stop'
$packageName    = '3dmark' 
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url            = 'http://akamai-dl.futuremark.com.akamaized.net/3DMark-v2-6-6238.zip'
$checksum       = 'FC5BC96E9614EDFEFD3E382DDF9049998DEE2B171D1523383A84C4B929BD26BB'
$extractDir     = "$toolsDir\extracted"
$fileLocation   = "$extractDir\3dmark-setup.exe"

New-Item $extractDir -type directory

$packageArgs = @{
  packageName   = $packageName
  unzipLocation = $extractDir
  fileType      = 'ZIP' 
  url           = $url
  checksum      = $checksum
  checksumType  = 'sha256'
}

Install-ChocolateyZipPackage @packageArgs 

$packageArgs = @{
  packageName    = $packageName
  fileType       = 'EXE'
  file           = $fileLocation
  silentArgs     = '/S'
  validExitCodes = @(0)
  softwareName   = '3DMark*'
}
 
Install-ChocolateyInstallPackage @packageArgs

Remove-Item $extractDir -Recurse -Force | out-null
Start-WaitandStop "FMSISvc"
