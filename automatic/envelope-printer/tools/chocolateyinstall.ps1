$packageName    = 'envelope-printer'
$installerType  = 'exe'
$url            = 'https://www.tweaking.com/files/setups/tweaking.com_envelope_printer_setup.exe'
$checksum       = '0AB93566CD1C86E98AB2C8009739C77D16E769963895B19F116468F47224DFF7'
$silentArgs     = '/S'
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$validExitCodes = @(0,1)
$softwareName   = 'Tweaking.com - Envelope Printer'

$packageArgs = @{
  packageName   = $packageName
  unzipLocation = $toolsDir  
  fileType      = $installerType
  url           = $url
  validExitCodes= $validExitCodes
  silentArgs    = $silentArgs
  softwareName  = $softwareName
  checksum      = $checksum
  checksumType  = 'sha256' 
}

Install-ChocolateyPackage @packageArgs

