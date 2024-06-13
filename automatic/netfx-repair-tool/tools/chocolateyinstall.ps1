$ErrorActionPreference = 'Stop';
$packageName  = 'netfx-repair-tool'
$toolsDir     = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url          = 'https://download.microsoft.com/download/2/B/D/2BDE5459-2225-48B8-830C-AE19CAF038F1/NetFxRepairTool.exe'
$checksum     = '4B8F1A54B8CAA28594D39C4628F6AD28EAF4A26D538BAB2F1EAB79E61199B142'
$checksumType = 'sha256'
$portableEXE  = "$toolsDir\NetFxRepairTool.exe"
$ShortcutName = 'Microsoft .NET Framework Repair Tool.lnk'

$packageArgs = @{
  packageName   = $packageName
  fileType      = 'EXE'
  url           = $url
  FileFullPath  = $portableEXE
  softwareName  = ''
  checksum      = $checksum
  checksumType  = $checksumType
}


Get-ChocolateyWebFile @packageArgs

Install-ChocolateyShortcut -shortcutFilePath "$env:Public\Desktop\$ShortcutName.lnk" -targetPath $portableEXE -WorkingDirectory "$toolsDir"
Install-ChocolateyShortcut -shortcutFilePath "$env:ProgramData\Microsoft\Windows\Start Menu\Programs\$ShortcutName.lnk" -targetPath $portableEXE -WorkingDirectory "$toolsDir"
