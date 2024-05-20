$ErrorActionPreference = 'Stop'
$packageName    = 'solarwinds-take-control-viewer'
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url            = 'https://swi-rc.cdn-sw.net/logicnow/Updates/7.50.02/TakeControlViewerInstall-7.50.02-20230914.exe'
$checksum       = 'FA5461F6E7C7219CF11850E3B61CA0ABD560E1DD5BB7BBCB9B6E1CF109330F30'

$packageArgs = @{
  packageName    = $packageName
  fileType       = 'EXE'
  url            = $url
  validExitCodes = @(0,1)
  silentArgs     = '/S'
  softwareName   = 'Take Control Viewer'
  checksum       = $checksum
  checksumType   = 'sha256'
}

Install-ChocolateyPackage @packageArgs

Start-CheckandStop "TakeControlRDLdr"
Start-CheckandStop "TakeControlRDViewer"
