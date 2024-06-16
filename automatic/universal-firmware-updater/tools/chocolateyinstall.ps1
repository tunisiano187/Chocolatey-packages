$ErrorActionPreference = 'Stop'
$packageName= 'universal-firmware-updater' 
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url        = 'http://download.wdc.com/fwupdater/Win/WDFirmwareUpdater.zip'
$checksum   = '989B4B8E960476C325292175B540EA9D03CAC40EE27EF25EA205375A01F5AD74'

$packageArgs = @{
  packageName   = $packageName
  unzipLocation = $toolsDir
  fileType      = 'ZIP' 
  url           = $url
  checksum      = $checksum
  checksumType  = 'sha256' 
}

Install-ChocolateyZipPackage @packageArgs

Install-ChocolateyShortcut -shortcutFilePath "$env:Public\Desktop\WD Firmware Updater.lnk" -targetPath "$toolsDir\WDFirmwareUpdater.exe" -WorkingDirectory "$toolsDir"
Install-ChocolateyShortcut -shortcutFilePath "$env:ProgramData\Microsoft\Windows\Start Menu\Programs\WD Firmware Updater.lnk" -targetPath "$toolsDir\WDFirmwareUpdater.exe" -WorkingDirectory "$toolsDir"