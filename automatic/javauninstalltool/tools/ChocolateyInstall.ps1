$ErrorActionPreference = 'Stop'
$packageName  = 'javauninstalltool'
$toolsDir     = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url          = 'https://javadl-esd-secure.oracle.com/update/jut/JavaUninstallTool.exe'
$checksum     = 'C542BD3490F56D7E35C0F6B6F468E083906F3BBF09A41DC409A6B982DEEA29B2'
$checksumType = 'sha256'
$shortcutName = 'Java Uninstall Tool.lnk'
$portableEXE  = 'JavaUninstallTool.exe'

$packageArgs = @{
  packageName   = $packageName
  fileType      = 'EXE'
  url           = $url
  FileFullPath  = "$toolsDir\JavaUninstallTool.exe"
  softwareName  = ''
  checksum      = $checksum
  checksumType  = $checksumType
}

Get-ChocolateyWebFile @packageArgs

Install-ChocolateyShortcut -shortcutFilePath "$env:Public\Desktop\$shortcutName" -targetPath "$toolsDir\$portableEXE" -WorkingDirectory "$toolsDir\"
Install-ChocolateyShortcut -shortcutFilePath "$env:ProgramData\Microsoft\Windows\Start Menu\Programs\$shortcutName" -targetPath "$toolsDir\$portableEXE" -WorkingDirectory "$toolsDir\"
