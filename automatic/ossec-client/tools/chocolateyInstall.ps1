$ErrorActionPreference = 'Stop'
$url            = 'https://updates.atomicorp.com/channels/atomic/windows/ossec-agent-win32-3.7.0-24343.exe'
$checksum       = '862b31fd64c70c760278a0d5408032e26dc6814a1ae24d64b5f3ae0ee2b343a4'
$checksumType   = 'sha256'

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  url            = $url
  installerType  = 'exe'
  checksum       = $checksum
  checksumType   = $checksumType
  silentArgs     = '/S'
  validExitCodes = @(0)
}

Install-ChocolateyPackage @packageArgs
