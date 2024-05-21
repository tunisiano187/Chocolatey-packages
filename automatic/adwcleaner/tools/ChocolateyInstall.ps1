$ErrorActionPreference = 'Stop'
$packageName       = 'adwcleaner' 
$toolsDir          = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
#$url               = 'https://downloads.malwarebytes.com/file/adwcleaner'
$url               = 'https://adwcleaner.malwarebytes.com/adwcleaner?channel=release'
$checksum          = '1F544DA66675521A649E632108F86AFB351AD336BD34B7B5C3D290827EBEEF54'
$shortcutName      = 'AdwCleaner.lnk'
$portableEXE       = "adwcleaner_$ENV:packageVersion.exe"

$packageArgs = @{
  packageName   = $packageName
  fileType      = 'EXE'
  url           = $url
  FileFullPath  = "$toolsDir\$portableEXE"
  softwareName  = ''
  checksum      = $checksum
  checksumType  = 'sha256'
}
 
Get-ChocolateyWebFile @packageArgs

Install-BinFile -Name adwcleaner -Path "$toolsDir\$portableEXE"

Install-ChocolateyShortcut -shortcutFilePath "$ENV:Public\Desktop\$shortcutName" -targetPath "$toolsDir\$portableEXE" -WorkingDirectory "$toolsDir\"
Install-ChocolateyShortcut -shortcutFilePath "$ENV:ProgramData\Microsoft\Windows\Start Menu\Programs\$shortcutName" -targetPath "$toolsDir\$portableEXE" -WorkingDirectory "$toolsDir\"

Remove-Item $toolsDir\*.exe -Exclude "adwcleaner_$ENV:packageVersion.exe" | Out-Null #del old vers
Remove-Item $ENV:ChocolateyInstall\bin\adwcleaner_*.exe  | Out-Null #del old vers' shims
