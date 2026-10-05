$ErrorActionPreference = 'Stop'
$packageName  = 'frink'
$toolsDir     = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url          = 'https://frinklang.org/frinkjar/frink.jar'
$checksum     = '16592E66714353FDB292AD76A4D71E01340C648A151BD8A5271CD21B1B842286'
$checksumType = 'sha256'
$ExeFile      = 'frink.jar'
$ShortcutName = 'Frink.lnk'
$FileFullPath = "$toolsDir\$ExeFile"


$packageArgs = @{
  packageName   = $packageName
  url           = $url
  FileFullPath  = $FileFullPath
  softwareName  = 'frink'
  checksum      = $checksum
  checksumType  = $checksumType
}

Get-ChocolateyWebFile @packageArgs

Install-ChocolateyShortcut -shortcutFilePath "$env:Public\Desktop\$ShortcutName" -targetPath "$toolsDir\$ExeFile" -iconLocation "$toolsDir\frink.ico"
Install-ChocolateyShortcut -shortcutFilePath "$env:ProgramData\Microsoft\Windows\Start Menu\Programs\$ShortcutName" -targetPath "$toolsDir\$ExeFile" -WorkingDirectory "$toolsDir" -iconLocation "$toolsDir\frink.ico"
