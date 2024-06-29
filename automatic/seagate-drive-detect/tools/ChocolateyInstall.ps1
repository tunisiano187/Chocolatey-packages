$packageName = 'seagate-drive-detect' 
$toolsDir    = $(Split-Path -parent $MyInvocation.MyCommand.Definition)
$url         = 'http://support.seagate.com/kbimg/utils/drivedetect.exe' 
$checksum    = 'D735ED06FA1D1EC42F7299DD4959CD7B49885ECC5C218A1BB83943FD4D4FFCB1'
$PortableEXE = "$toolsDir\drivedetect.exe"

$packageArgs = @{
  packageName   = $packageName
  fileType      = 'EXE'
  url           = $url
  FileFullPath  = $PortableEXE
  softwareName  = ''
  checksum      = $checksum
  checksumType  = 'sha256'
}

Get-ChocolateyWebFile @packageArgs

Install-ChocolateyShortcut -shortcutFilePath "$ENV:Public\Desktop\Seagate Drive Detect.lnk" -targetPath "$toolsDir\drivedetect.exe"
Install-ChocolateyShortcut -shortcutFilePath "$ENV:ProgramData\Microsoft\Windows\Start Menu\Programs\Seagate Drive Detect.lnk" -targetPath "$toolsDir\drivedetect.exe"
