$ErrorActionPreference = 'Stop'
$url            = 'https://updates.atomicorp.com/channels/atomic/windows/ossec-agent-win32-4.4.0-42108.exe'
$checksum       = '7a4d5e0594577d7867a57ae0497f81a6d8cf4dba59188864a84f2e9baf274bee'
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
