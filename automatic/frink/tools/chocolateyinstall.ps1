$ErrorActionPreference = 'Stop'
$packageName  = 'frink'
$toolsDir     = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url          = 'https://frinklang.org/frinkjar/frink.jar'
$checksum     = 'C12754973B41F31735404A2ECDFB682DECEC639DC148CE4E760CE79E0F5652BC'
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
