$ErrorActionPreference = 'Stop'
$packageName = 'eduactiv8'
$toolsDir    = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$File         = "$toolsDir\eduactiv8-$($env:chocolateyPackageVersion)-win.zip"
$extractDir  = "$toolsDir\eduactiv8\"
$Shortcut    = 'eduActiv8.lnk'
$ProgramEXE  = 'eduActiv8.exe'


$packageArgs = @{
  PackageName     = $packageName
  Destination     = $toolsDir
  FileFullPath    = $File
}

Install-ChocolateyZipPackage @packageArgs

Install-ChocolateyShortcut -shortcutFilePath "$env:Public\Desktop\$Shortcut" -targetPath "$extractDir\$ProgramEXE" -WorkingDirectory "$extractDir"
Install-ChocolateyShortcut -shortcutFilePath "$env:ProgramData\Microsoft\Windows\Start Menu\Programs\$Shortcut" -targetPath "$extractDir\$ProgramEXE" -WorkingDirectory "$extractDir"

Remove-Item $File | out-null
