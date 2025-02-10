$ErrorActionPreference = 'Stop'
$packageName  = 'frink'
$toolsDir     = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url          = 'https://frinklang.org/frinkjar/frink.jar'
$checksum     = '56EF8996E154667422A876EE2DF671F22E2350399A6C04E9B9D6786B611D0D49'
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
