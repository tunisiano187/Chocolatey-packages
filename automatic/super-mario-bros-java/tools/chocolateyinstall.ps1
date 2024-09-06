$ErrorActionPreference = 'Stop'
$packageName  = 'super-mario-bros-java'
$toolsDir     = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url          = 'http://downloads.sourceforge.net/project/super-mario-bros-java/Mario.jar'
$checksum     = '9E6EF2EEC9FB5B1ACC58B07699948672F1C39D5C213759C2BB5988F48E24C363'
$ExeFile      = 'Mario.jar'
$ShortcutName = 'Super Mario Bros Java.lnk'
$FileFullPath = "$toolsDir\$ExeFile"

$packageArgs = @{
  packageName   = $packageName
  fileType      = 'EXE'
  url           = $url
  FileFullPath  = $FileFullPath
  softwareName  = ''
  checksum      = $checksum
  checksumType  = 'sha256'
}

Get-ChocolateyWebFile @packageArgs

Install-ChocolateyShortcut -shortcutFilePath "$env:Public\Desktop\$ShortcutName" -targetPath "$toolsDir\$ExeFile" -iconLocation "$toolsDir\Mario.ico"
Install-ChocolateyShortcut -shortcutFilePath "$env:ProgramData\Microsoft\Windows\Start Menu\Programs\$ShortcutName" -targetPath "$toolsDir\$ExeFile" -WorkingDirectory "$toolsDir" -iconLocation "$toolsDir\Mario.ico"














