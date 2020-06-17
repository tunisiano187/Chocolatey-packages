$packageName = 'xolidosigndesktop'
$installerType = 'EXE'
$url32 = ''
$checksumtype = 'sha256'
$checksum32 = ''

$silentArgs = '/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-' 
$validExitCodes = @(0) 

$packageArgs = @{
  packageName   = $packageName
  fileType      = $installerType
  url           = $url32
  silentArgs    = $silentArgs
  validExitCodes= @(0,3010)
  softwareName  = 'xolido*'
  checksum      = $checksum
  checksumType  = 'sha256'
}

Install-ChocolateyPackage @packageArgs