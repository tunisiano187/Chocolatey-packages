$ErrorActionPreference = 'Stop'
$packageName           = 'bills-jammin-jukebox' 
$installerType         = 'exe'
$silentArgs            = '/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP- /MERGETASKS=desktopicon'
$toolsDir              = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url                   = "$toolsDir\bjjsetup-6.1-installer-win32.exe"

$packageArgs = @{
  packageName   = $packageName
  unzipLocation = $toolsDir
  fileType      = $installerType
  url           = $url
  silentArgs    = $silentArgs
  softwareName  = 'Bill''s Jammin Jukebox*' 
  checksum      = 'C0C676A085DE4F88CAF6DB90864A6248036C6508A11062E4D258DE3F2C3E54DA'
  checksumType  = 'sha256'  
  }
  
Install-ChocolateyPackage @packageArgs
