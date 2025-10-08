$ErrorActionPreference = 'Stop'
$packageName        = 'adwcleaner'
$toolsDir           = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url                = 'https://downloads.malwarebytes.com/file/adwcleaner'
$checksum           = '51C60064386161329ED74F862B7CCDB008E13AD0195465F7C48754AD2320BCED'
$checksumType       = 'SHA256'
$shortcutName       = 'AdwCleaner.lnk'
$portableEXE        = "adwcleaner.exe"

$packageArgs = @{
  packageName   = $packageName
  fileType      = 'EXE'
  url           = $url
  FileFullPath  = "$toolsDir\$portableEXE"
  softwareName  = ''
  checksum      = $checksum
  checksumType  = $checksumType
}

Get-ChocolateyWebFile @packageArgs

Install-BinFile -Name adwcleaner -Path "$toolsDir\$portableEXE"

Install-ChocolateyShortcut -shortcutFilePath "$ENV:Public\Desktop\$shortcutName" -targetPath "$toolsDir\$portableEXE" -WorkingDirectory "$toolsDir\"
Install-ChocolateyShortcut -shortcutFilePath "$ENV:ProgramData\Microsoft\Windows\Start Menu\Programs\$shortcutName" -targetPath "$toolsDir\$portableEXE" -WorkingDirectory "$toolsDir\"

Remove-Item $toolsDir\*.exe -Exclude "adwcleaner.exe" | Out-Null #del old vers
Remove-Item $ENV:ChocolateyInstall\bin\adwcleaner_*.exe  | Out-Null #del old vers' shims
