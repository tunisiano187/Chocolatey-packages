# https://github.com/Javanaise/mrboom-libretro/releases
$ErrorActionPreference = 'Stop'
$toolsDir      = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$PortableEXE   = 'MrBoom.exe'
$ShortcutName  = 'MrBoom.lnk'

$packageArgs = @{
  packageName    = 'mrboom'
  unzipLocation  = $toolsDir
  fileType       = 'ZIP' 
  url64          = "$toolsDir\MrBoom-win64-$env:ChocolateyPackageVersion.zip"
  }

Install-ChocolateyZipPackage @packageArgs

Install-ChocolateyShortcut -shortcutFilePath "$env:Public\Desktop\$ShortcutName" -targetPath "$toolsDir\$PortableEXE" -WorkingDirectory "$toolsDir\$packageName" -iconLocation "$toolsDir\mrboom.ico"
Install-ChocolateyShortcut -shortcutFilePath "$env:ProgramData\Microsoft\Windows\Start Menu\Programs\$ShortcutName" -targetPath "$toolsDir\$PortableEXE" -WorkingDirectory "$toolsDir\$packageName" -iconLocation "$toolsDir\mrboom.ico"

Remove-Item "$toolsDir\*.zip" | Out-Null
