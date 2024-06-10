$ErrorActionPreference = 'Stop'
$url           = 'https://www.seagate.com/files/www-content/support-content/downloads/seatools/_shared/downloads/SeaToolsWindowsInstaller.exe'
               # ^ persistent
$checksum      = '92194258048C2C033245931D5E8388083E48301498CD774C1CD2EEA3F278A0A5'

$packageArgs = @{
  packageName   = 'seatools'
  unzipLocation = $toolsDir
  fileType      = 'exe'
  url           = $url
  silentArgs    = '--mode unattended'
  softwareName  = 'SeaTools*' 
  checksum      = $checksum
  checksumType  = 'sha256'  
  }
Install-ChocolateyPackage @packageArgs
