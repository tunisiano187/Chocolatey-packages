$packageName = 'frogger' 
$toolsDir    = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url         = "$toolsDir\frogger.zip"
$checksum    = '3B0B5F3E2D596647816CB92431557886F8F55CA103ACFCC60B8B5FE3189DBFFF'
$Shortcut    = 'Frogger.lnk'
$ProgramEXE  = 'frogger_new.exe'

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