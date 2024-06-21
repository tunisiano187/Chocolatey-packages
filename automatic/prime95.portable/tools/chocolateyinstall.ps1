$ErrorActionPreference = 'Stop'
$packageName  = 'prime95.portable' 
$toolsDir     = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url          = 'http://www.mersenne.org/ftp_root/gimps/p95v303b6.win32.zip'
$checksum     = 'CA712CEB3C3A9642ACB6C6A45B9F3164A1F0AAEC72DAB4E47083AB07916B03F4'
$checksumType = 'sha256'
$url64        = 'http://www.mersenne.org/ftp_root/gimps/p95v303b6.win64.zip'
$checksum64   = '533EDA6A585CD047B3D41FBA85BD52798AD6F4D8572B25A5F01FFDAAE11509DA'
$ExeFile      = 'prime95.exe'
$ShortcutName = 'Prime95'

$packageArgs = @{
  packageName   = $packageName
  unzipLocation = $toolsDir
  fileType      = 'ZIP' 
  url           = $url
  url64         = $url64
  checksum      = $checksum
  checksumType  = $checksumType
  checksum64    = $checksum64
  checksumType64= $checksumType 
}

Install-ChocolateyZipPackage @packageArgs

Install-ChocolateyShortcut -shortcutFilePath "$env:Public\Desktop\$ShortcutName.lnk" -targetPath "$env:ChocolateyInstall\lib\$packageName\tools\$ExeFile"
Install-ChocolateyShortcut -shortcutFilePath "$env:ProgramData\Microsoft\Windows\Start Menu\Programs\$ShortcutName.lnk" -targetPath "$toolsDir\$ExeFile" -WorkingDirectory "$toolsDir"