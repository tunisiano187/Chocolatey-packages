$ErrorActionPreference = 'Stop'
$packageName = 'eduactiv8'
$toolsDir    = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url         = "$toolsDir\eduactiv8-3.80.411-win.zip"
$checksum    = '3BE1DE5E8B557EE1D66BB9AF76B11D770184AC2F1ABF6D80B69113FA7F9B8CBB'
$extractDir  = "$toolsDir\eduactiv8-3.80.411.rc.win\"
$Shortcut    = 'eduActiv8.lnk'
$ProgramEXE  = 'eduActiv8.exe'


$packageArgs = @{
  packageName    = $packageName
  unzipLocation  = $toolsDir
  fileType       = 'ZIP' 
  url            = $url
  checksum       = $checksum 
  checksumType   = 'sha256'
}

Install-ChocolateyZipPackage @packageArgs

Install-ChocolateyShortcut -shortcutFilePath "$env:Public\Desktop\$Shortcut" -targetPath "$extractDir\$ProgramEXE" -WorkingDirectory "$extractDir"
Install-ChocolateyShortcut -shortcutFilePath "$env:ProgramData\Microsoft\Windows\Start Menu\Programs\$Shortcut" -targetPath "$extractDir\$ProgramEXE" -WorkingDirectory "$extractDir"

Remove-Item $url | out-null
