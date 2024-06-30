$ErrorActionPreference = 'Stop'
$packageName      = 'open-mahjong-java'
$toolsDir         = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url              = 'https://downloads.sourceforge.net/project/openmahjong/OpenMahjong%20V3.1.zip'
$checksum         = 'B326F156DE72920E916508CA6EFADCD61488AE51757C874B19602307F8D6F06A'
$ExeFile          = 'OpenMahjong.jar'
$ShortcutName     = 'Open Mahjong.lnk'

$packageArgs = @{
  packageName    = $packageName
  unzipLocation  = $toolsDir
  fileType       = 'ZIP' 
  url            = $url
  checksum       = $checksum 
  checksumType   = 'sha256'
}

Install-ChocolateyZipPackage @packageArgs

Install-ChocolateyShortcut -shortcutFilePath "$env:Public\Desktop\$ShortcutName" -targetPath "$toolsDir\$ExeFile" -WorkingDirectory $toolsDir -iconLocation "$toolsDir\OpenMahjong.ico"
Install-ChocolateyShortcut -shortcutFilePath "$env:ProgramData\Microsoft\Windows\Start Menu\Programs\$ShortcutName" -targetPath "$toolsDir\$ExeFile" -WorkingDirectory $toolsDir -iconLocation "$toolsDir\OpenMahjong.ico"














