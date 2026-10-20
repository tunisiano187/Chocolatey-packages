$ErrorActionPreference = 'Stop'
$url            = 'https://updates.atomicorp.com/channels/atomic/windows/ossec-agent-win32-4.4.1-42225.exe'
$checksum       = 'ddfb0aa3629fd3b651a218a5f6c1b5599e8f5e838500da05b8c79102b8b278ec'
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
