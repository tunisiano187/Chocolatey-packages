$ErrorActionPreference = 'Stop'
$url            = 'https://updates.atomicorp.com/channels/atomic/windows/ossec-agent-win32-4.3.0-41650.exe'
$checksum       = 'd8deaa77a985504cd94e0765400cfb8a1253bcf8762b46e0f6c917f574db3820'
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
