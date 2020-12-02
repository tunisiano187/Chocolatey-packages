$ErrorActionPreference = 'Stop'
$packageName    = $env:ChocolateyPackageName
$installerType  = 'EXE'
$url32          = 'https://www.xolido.com/instaladores/SetupXolidoSign.exe'
$checksum32     = '151509c6dc8be02bce9853b22f76ed10d62189775b4128388189d1f24f73fed1'
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
