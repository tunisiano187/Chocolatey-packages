$ErrorActionPreference = 'Stop'
$packageName  = 'video-repair-software'
$toolsDir     = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url          = 'http://grauonline.de/download/videorepair.zip'
$checksum     = '2E4B9146FB4FF64A84B8E70925C7F6B542C84E68590FE62AFB2840152CD5F817'
$shortcutName = 'Video Repair Software.lnk'
$exe          = 'videorepair\gs.exe'


$packageArgs = @{
  packageName    = $packageName
  unzipLocation  = $toolsDir
  fileType       = 'ZIP' 
  url            = $url
  checksum       = $checksum
  checksumType   = 'sha256'
}

Install-ChocolateyZipPackage @packageArgs

Install-ChocolateyShortcut -shortcutFilePath "$env:Public\Desktop\$shortcutName" -targetPath "$toolsDir\$exe" -WorkingDirectory "$toolsDir\$packageName"
Install-ChocolateyShortcut -shortcutFilePath "$env:ProgramData\Microsoft\Windows\Start Menu\Programs\$shortcutName" -targetPath "$toolsDir\$exe" -WorkingDirectory "$toolsDir\$packageName"

