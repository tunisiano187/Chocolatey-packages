$ErrorActionPreference = 'Stop'
$packageName  = 'frink'
$toolsDir     = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url          = 'https://frinklang.org/frinkjar/frink.jar'
$checksum     = '2D10665D18A07C3A45690532780BB7335F319E49F645F2F59505CC444F5C273B'
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
