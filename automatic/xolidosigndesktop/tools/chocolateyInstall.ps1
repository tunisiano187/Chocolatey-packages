$ErrorActionPreference = 'Stop'
$packageName    = $env:ChocolateyPackageName
$installerType  = 'EXE'
$url32          = 'https://www.xolido.com/instaladores/SetupXolidoSign.exe'
$checksum32     = '271e541af715a237e4fcd9148cd7ef43698965442f5b728627509164bf045dd6'
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
