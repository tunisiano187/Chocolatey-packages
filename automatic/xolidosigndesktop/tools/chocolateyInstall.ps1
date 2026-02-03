$ErrorActionPreference = 'Stop'
$packageName    = $env:ChocolateyPackageName
$installerType  = 'EXE'
$url32          = 'https://www.xolido.com/instaladores/SetupXolidoSign.exe'
$checksum32     = '44eedd538fce8a2d5a961389ab375eb37f889dde10b8f6bf6a71f4633c2ad3d2'
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
