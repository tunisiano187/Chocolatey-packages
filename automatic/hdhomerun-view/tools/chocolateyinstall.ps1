$ErrorActionPreference = 'Stop'
$url            = 'https://download.silicondust.com/hdhomerun/hdhomerun_windows_20260326.exe'
$checksum       = '261A2D7849034B7C1EAB253DF3516F6DF120E1A9D56D16F8645D28D28298264F'
$checksumType   = 'sha256'

$packageArgs = @{
  packageName   = $env:chocolateyPackageName
  fileType      = 'EXE'
  url           = $url
  validExitCodes= @(0, 3010, 1641)
  silentArgs    = '/quiet /qn /norestart'
  softwareName  = 'HDHomeRun*'
  checksum      = $checksum
  checksumType  = $checksumType
}

Install-ChocolateyPackage @packageArgs

# UPDATE INSTRUCTIONS:
# Update checksum
