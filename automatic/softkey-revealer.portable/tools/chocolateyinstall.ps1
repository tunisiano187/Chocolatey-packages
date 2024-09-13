$ErrorActionPreference = 'Stop'
$packageName  = 'softkey-revealer.portable' 
$toolsDir     = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url          = 'https://sites.google.com/site/cakirbey/SoftKeyRevealer.zip'
$url64        = $url
$ExeFile      = 'SoftKeyRevealer.exe'
$ShortcutName = 'SoftKey Revealer'

$packageArgs = @{
  packageName   = $packageName
  unzipLocation = $toolsDir
  fileType      = 'ZIP' 
  url           = $url
  checksum      = '452B25DF7F2E4AEB7FEC2A95BDCBC9E884B6EDEC8390DF87C4A9818DFC5F38F5'
  checksumType  = 'sha256'  
}

Install-ChocolateyZipPackage @packageArgs

Install-ChocolateyShortcut -shortcutFilePath "$env:Public\Desktop\$ShortcutName.lnk" -targetPath "$env:ChocolateyInstall\lib\$packageName\tools\$ExeFile"
Install-ChocolateyShortcut -shortcutFilePath "$env:ProgramData\Microsoft\Windows\Start Menu\Programs\$ShortcutName.lnk" -targetPath "$toolsDir\$ExeFile" -WorkingDirectory "$toolsDir"