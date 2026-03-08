$ErrorActionPreference = 'Stop'
$packageName  = 'javauninstalltool' 
$toolsDir     = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url          = 'https://javadl-esd-secure.oracle.com/update/jut/JavaUninstallTool.exe'
$checksum     = '06FBF93F1C0EBD3585F4C6CC1095BF32109CD8233E4D49780E558624F4FCB7C2'
$shortcutName = 'Java Uninstall Tool.lnk'
$portableEXE  = 'JavaUninstallTool.exe'

$packageArgs = @{
  packageName   = $packageName
  fileType      = 'EXE'
  url           = $url
  FileFullPath  = "$toolsDir\JavaUninstallTool.exe"
  softwareName  = ''
  checksum      = $checksum
  checksumType  = 'sha256'
}
 
Get-ChocolateyWebFile @packageArgs

Install-ChocolateyShortcut -shortcutFilePath "$env:Public\Desktop\$shortcutName" -targetPath "$toolsDir\$portableEXE" -WorkingDirectory "$toolsDir\"
Install-ChocolateyShortcut -shortcutFilePath "$env:ProgramData\Microsoft\Windows\Start Menu\Programs\$shortcutName" -targetPath "$toolsDir\$portableEXE" -WorkingDirectory "$toolsDir\"