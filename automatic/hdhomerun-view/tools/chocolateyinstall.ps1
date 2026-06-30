$ErrorActionPreference = 'Stop'
$url            = 'https://download.silicondust.com/hdhomerun/hdhomerun_windows_20260629.exe'
$checksum       = 'C32872053782BBAD833E51ED0FD08EF6F8F1D5483A92F51657C2BFD655FAAE90'
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
