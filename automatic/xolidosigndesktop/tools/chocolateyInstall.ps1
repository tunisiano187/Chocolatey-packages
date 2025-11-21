$ErrorActionPreference = 'Stop'
$packageName    = $env:ChocolateyPackageName
$installerType  = 'EXE'
$url32          = 'https://www.xolido.com/instaladores/SetupXolidoSign.exe'
$checksum32     = '6449152e6534e660a1851a3c983be53783a43a08b82771c597acb0f286d9fec8'
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
