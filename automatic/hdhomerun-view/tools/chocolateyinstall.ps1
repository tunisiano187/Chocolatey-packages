$ErrorActionPreference = 'Stop'
$url            = 'https://download.silicondust.com/hdhomerun/hdhomerun_windows_20261107.exe'
$checksum       = '9E83770876A6B8416603EC93759C3CE418409ECF6B612BA6B8FFB5A7C4E63525'
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
