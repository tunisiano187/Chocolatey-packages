$ErrorActionPreference = 'Stop';
$packageName  = 'netfx-repair-tool'
$toolsDir     = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url          = 'https://download.microsoft.com/download/4/7/7/477a3afe-b888-4553-a6a2-965287eeef89/NetFxRepairTool.exe'
$checksum     = '82AC76B9F2648597012A15EF1EDEDAA7C0682DF2E73D5E751124214267D9C278'
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
