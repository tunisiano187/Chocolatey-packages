$packageName = 'burgertime' 
$toolsDir    = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url         = "$toolsDir\burgertime.zip"
$checksum    = 'E2783211370F5D910D43966B1A0517713D97C085918F35C44647E5A7AA34000E'
$Shortcut    = 'Burger Time.lnk'
$ProgramEXE  = 'burgertime.exe'

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