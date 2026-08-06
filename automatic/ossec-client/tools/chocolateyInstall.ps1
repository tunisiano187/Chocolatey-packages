$ErrorActionPreference = 'Stop'
$url            = 'https://updates.atomicorp.com/channels/atomic/windows/ossec-agent-win32-4.2.0-41214.exe'
$checksum       = '2144898d48e641b1f0759e3d9765df5f3fcf1fd2e617de0e2f31fef757e64f98'
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
