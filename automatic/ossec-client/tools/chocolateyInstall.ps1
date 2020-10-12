$ErrorActionPreference = 'Stop'

$packageArgs = @{
  packageName    = 'ossec-client'
  url            = 'https://updates.atomicorp.com/channels/atomic/windows/ossec-agent-win32-3.3.0-7006.exe'
  installerType  = 'exe'
  checksum       = 'e60a87fee3fbcba6ad6eb6abcb052eb2f6c79766e468f50c5615e6cc4a92b600'
  checksumType   = 'sha256'
  silentArgs     = '/S'
  validExitCodes = @(0)
}

Install-ChocolateyPackage @packageArgs


