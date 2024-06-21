$ErrorActionPreference = 'Stop'
$packageName  = 'prime95.portable'
$toolsDir     = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url          = 'https://www.mersenne.org/download/software/v30/30.19/p95v3019b20.win32.zip'
$checksum     = 'a77c9297bd80dffcb7e2e7e6e89db674126c06a2fe8e769dcec06da2e66e8516'
$checksumType = 'sha256'
$url64        = 'https://www.mersenne.org/download/software/v30/30.19/p95v3019b20.win64.zip'
$checksum64   = 'd9475f2ff3f4a6a701abc49a86a66126cb48abd10bda6fa87039d98fa8756bca'
$ExeFile      = 'prime95.exe'
$ShortcutName = 'Prime95'

$packageArgs = @{
  packageName   = $packageName
  unzipLocation = $toolsDir
  fileType      = 'ZIP'
  url           = $url
  url64         = $url64
  checksum      = $checksum
  checksumType  = $checksumType
  checksum64    = $checksum64
  checksumType64= $checksumType
}

Install-ChocolateyZipPackage @packageArgs

Install-ChocolateyShortcut -shortcutFilePath "$env:Public\Desktop\$ShortcutName.lnk" -targetPath "$env:ChocolateyInstall\lib\$packageName\tools\$ExeFile"
Install-ChocolateyShortcut -shortcutFilePath "$env:ProgramData\Microsoft\Windows\Start Menu\Programs\$ShortcutName.lnk" -targetPath "$toolsDir\$ExeFile" -WorkingDirectory "$toolsDir"
