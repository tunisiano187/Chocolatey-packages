$ErrorActionPreference = 'Stop'
$url            = 'https://download.silicondust.com/hdhomerun/hdhomerun_windows.exe'
$checksum       = 'CD35D3CCAC3B7ADCFF88BB14D34D4F55074B52043C8DE7A2525525C0C72BA871'

$packageArgs = @{
  packageName   = $env:chocolateyPackageName
  fileType      = 'EXE'
  url           = $url
  validExitCodes= @(0, 3010, 1641)
  silentArgs    = '/quiet /qn /norestart'
  softwareName  = 'HDHomeRun*'
  checksum      = $checksum
  checksumType  = 'sha256'
}

Install-ChocolateyPackage @packageArgs

# UPDATE INSTRUCTIONS:
# Update checksum
