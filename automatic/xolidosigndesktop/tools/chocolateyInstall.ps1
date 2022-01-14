$ErrorActionPreference = 'Stop'
$packageName    = $env:ChocolateyPackageName
$installerType  = 'EXE'
$url32          = 'https://www.xolido.com/instaladores/SetupXolidoSign.exe'
$checksum32     = '6b17c08c2fa675d0cc7953f0660058fe77bf8e7c5067d5822d0c69ecbb1044be'
$checksumType   = 'sha256'

$silentArgs     = '/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-'
$validExitCodes = @(0)

$packageArgs = @{
  packageName   = $packageName
  fileType      = $installerType
  url           = $url32
  silentArgs    = $silentArgs
  validExitCodes= $validExitCodes
  softwareName  = 'xolido*'
  checksum      = $checksum32
  checksumType  = $checksumtype
}

Install-ChocolateyPackage @packageArgs
