$ErrorActionPreference = 'Stop';
$packageName  = 'lan-speed-test.portable'
$toolsDir     = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url          = 'http://www.totusoft.com/files/LAN_SpeedTestPortable.zip'
$checksum     = '5E7C6AD4B815D72409433AD3AE1ECBC5927963B4B8C709D046E68AD6A6C4A719'
$shortcutName = 'LAN Speed Test.lnk'
$portableEXE  = "$toolsDir\LAN_SpeedTestPortable.exe";

$packageArgs = @{
  packageName   = $packageName
  unzipLocation = $toolsDir
  fileType      = 'ZIP' 
  url           = $url
  checksum      = $checksum
  checksumType  = 'sha256'
}

Install-ChocolateyZipPackage @packageArgs
Install-ChocolateyShortcut -shortcutFilePath "$ENV:Public\Desktop\$shortcutName" -targetPath $portableEXE -WorkingDirectory $toolsDir
Install-ChocolateyShortcut -shortcutFilePath "$ENV:ProgramData\Microsoft\Windows\Start Menu\Programs\$shortcutName" -targetPath $portableEXE -WorkingDirectory $toolsDir
