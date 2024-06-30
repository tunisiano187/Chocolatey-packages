$ErrorActionPreference = 'Stop'
$packageName    = 'winhue'
$installerType  = 'EXE'
$url            = 'https://github.com/Hyrules/WinHue3/releases/download/1.0/WinHue.3.0.3028.0.Setup.exe' 
$checksum       = '963183653C507246DD87DEB8623DAB5EAB9980E42547EC524BC0BFC8100604F2'

$packageArgs = @{
  packageName   = $packageName
  fileType      = 'EXE' 
  url           = $url
  silentArgs    = '/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-'
  validExitCodes= @(0)
  softwareName  = 'WinHue*'
  checksum      = $checksum
  checksumType  = 'sha256'   
}

Install-ChocolateyPackage @packageArgs
  