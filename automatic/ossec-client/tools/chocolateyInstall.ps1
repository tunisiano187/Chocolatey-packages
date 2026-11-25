$ErrorActionPreference = 'Stop'
$url            = 'https://updates.atomicorp.com/channels/atomic/windows/ossec-agent-win32-4.5.0-42764.exe'
$checksum       = '8ccd68d09f20398db7f35b80f8be07ed5c78e01a0312f1f9f380c14912022e51'
$checksumType   = 'sha256'

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  url            = $url
  installerType  = 'exe'
  checksum       = $checksum
  checksumType   = $checksumType
  silentArgs     = '/S'
  validExitCodes = @(0, 2)
}

Install-ChocolateyPackage @packageArgs
