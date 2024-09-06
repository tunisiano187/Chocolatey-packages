$packageName = 'pacman-revenge'
$toolsDir    = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url         = "$toolsDir\pacman_revenge.zip"
$checksum    = 'EDCCFAC7AFB117C6F094783956972F2D98B4001D4946D78E2D4720B165482FED'
$Shortcut    = 'Pacman The Ghosts Revenge.lnk'
$ProgramEXE  = 'pacman_revenge.exe'

$packageArgs = @{
  packageName    = $packageName
  unzipLocation  = $toolsDir
  fileType       = 'ZIP'
  url            = $url
  checksum       = $checksum
  checksumType   = 'sha256'
  }

Install-ChocolateyZipPackage @packageArgs

Install-ChocolateyShortcut -shortcutFilePath "$env:Public\Desktop\$Shortcut" -targetPath "$toolsDir\$ProgramEXE" -WorkingDirectory "$toolsDir"
Install-ChocolateyShortcut -shortcutFilePath "$env:ProgramData\Microsoft\Windows\Start Menu\Programs\$Shortcut" -targetPath "$toolsDir\$ProgramEXE"

Remove-Item $url | out-null
