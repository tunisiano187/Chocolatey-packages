$ErrorActionPreference = 'Stop'
$packageName  = 'frink'
$toolsDir     = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url          = 'https://frinklang.org/frinkjar/frink.jar'
$checksum     = '27640e9c1e9ad1a71bc5786cc3965c4c8958f34e60950f6e0e89ef2d95452e38'
$checksumType = 'sha256'
$ExeFile      = 'frink.jar'
$ShortcutName = 'Frink.lnk'
$FileFullPath = "$toolsDir\$ExeFile"


$packageArgs = @{
  packageName   = $packageName
  fileType      = 'EXE'
  url           = $url
  FileFullPath  = $FileFullPath
  softwareName  = ''
  checksum      = $checksum
  checksumType  = $checksumType
}

Get-ChocolateyWebFile @packageArgs

Install-ChocolateyShortcut -shortcutFilePath "$env:Public\Desktop\$ShortcutName" -targetPath "$toolsDir\$ExeFile" -iconLocation "$toolsDir\frink.ico"
Install-ChocolateyShortcut -shortcutFilePath "$env:ProgramData\Microsoft\Windows\Start Menu\Programs\$ShortcutName" -targetPath "$toolsDir\$ExeFile" -WorkingDirectory "$toolsDir" -iconLocation "$toolsDir\frink.ico"
