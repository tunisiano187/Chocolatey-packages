$packageName = 'xolidosigndesktop'
$installerType = 'EXE'
$url32 = 'http://www.xolido.com/instaladores/SetupXolidoSign.exe'
$checksumtype = 'sha256'
$checksum32 = '6cd3860665666a9efd13fd5ca33ee41807698f9c06788781094152811bf0db25'

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
