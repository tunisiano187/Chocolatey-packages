$ErrorActionPreference = 'Stop';
$packageName  = 'netfx-repair-tool'
$toolsDir     = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url          = 'https://download.microsoft.com/download/2/B/D/2BDE5459-2225-48B8-830C-AE19CAF038F1/NetFxRepairTool.exe'
$checksum     = '3B33161BB43F7508439C588D39692F8D225FC6864E09A2922DFC01366A7528DB'
$portableEXE  = "$toolsDir\NetFxRepairTool.exe"
$ShortcutName = 'Microsoft .NET Framework Repair Tool.lnk'

$packageArgs = @{
  packageName   = $packageName
  fileType      = 'EXE'
  url           = $url
  FileFullPath  = $portableEXE
  softwareName  = ''
  checksum      = $checksum
  checksumType  = 'sha256'
}


Get-ChocolateyWebFile @packageArgs

Install-ChocolateyShortcut -shortcutFilePath "$env:Public\Desktop\$ShortcutName.lnk" -targetPath $portableEXE -WorkingDirectory "$toolsDir"
Install-ChocolateyShortcut -shortcutFilePath "$env:ProgramData\Microsoft\Windows\Start Menu\Programs\$ShortcutName.lnk" -targetPath $portableEXE -WorkingDirectory "$toolsDir"
