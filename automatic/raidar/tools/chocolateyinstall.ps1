$ErrorActionPreference = 'Stop'
$packageName  = 'raidar'
$toolsDir     = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url          = 'https://www.downloads.netgear.com/files/GDC/READYNAS-COMMON/RAIDar_6.5.0.exe'
$checksum     = '05B7F4FC0FBF329D0C309378D5D1063FEF310F6A697D3D7FAD665DCA15A248E7'
$fileFullPath = "$toolsDir\RAIDar_" + "$ENV:ChocolateyPackageVersion" + ".exe"
$shortcutName = 'RAIDar'
$programEXE   = "RAIDar.exe"

if (Test-Path "$toolsDir\RAIDar.exe") {Remove-Item "$toolsDir\RAIDar.exe"}

$packageArgs = @{
  packageName   = $packageName
  unzipLocation = $toolsDir
  fileType      = 'EXE' 
  url           = $url
  checksum      = $checksum
  checksumType  = 'sha256'
  fileFullPath  = $fileFullPath
}

Get-ChocolateyWebFile @packageArgs

Rename-Item $fileFullPath "RAIDar.exe"

Install-ChocolateyShortcut -shortcutFilePath "$ENV:Public\Desktop\$shortcutName.lnk" -targetPath "$toolsDir\$programEXE"
Install-ChocolateyShortcut -shortcutFilePath "$ENV:ProgramData\Microsoft\Windows\Start Menu\Programs\$shortcutName.lnk" -targetPath "$toolsDir\$programEXE"
