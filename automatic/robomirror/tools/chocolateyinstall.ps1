$packageName   = 'robomirror'
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$installerType = 'exe'
$url           = 'https://downloads.sourceforge.net/project/robomirror/RoboMirror/RoboMirror%202.0%20Setup.exe'
$silentArgs    = '/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-'
Install-ChocolateyPackage "$packageName" "$installerType" "$silentArgs" "$url" "$url64"

$packageArgs = @{
  packageName   = $packageName
  unzipLocation = $toolsDir
  fileType      = $installerType
  url           = $url
  silentArgs    = $silentArgs
  softwareName  = 'RoboMirror*' 
  checksum      = '16ACF606E19DA88FF27F665377D203A8D1C6A100EFEBF63C0E37AD08C3F882DD'
  checksumType  = 'sha256'  
  }
  
Install-ChocolateyPackage @packageArgs