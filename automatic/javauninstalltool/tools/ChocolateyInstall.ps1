$ErrorActionPreference = 'Stop'
$packageName  = 'javauninstalltool'
$toolsDir     = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url          = 'https://javadl-esd-secure.oracle.com/update/jut/JavaUninstallTool.exe'
$checksum     = '73788DCC98F1AA2E20984493A68ABB357E8EB3779FBD59D940614821DA890BC6'
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
