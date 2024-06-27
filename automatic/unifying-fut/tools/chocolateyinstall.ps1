$ErrorActionPreference = 'Stop';
$toolsDir     = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url64        = 'https://download01.logi.com/web/ftp/pub/techsupport/keyboards/FirmwareUpdateTool_3.2.276959_x64.exe'
$checksum64   = 'C02429E3B3CF9F53233B85CA6971A54BEA20830C3BC32DF788A142813E02FC38'
$exe          = 'FirmwareUpdateTool_2.6.201219_x86.exe'
$shortcutName = 'Logitech Firmware Update Tool.lnk'


$packageArgs = @{
    packageName    = 'unifying-fut'
    url64          = $url64
    checkum64      = $checksum64
    checksumType64 = 'sha256'
    fileType       = 'EXE'
    FileFullPath   = "$toolsDir\$exe"
}

Get-ChocolateyWebFile @packageArgs

Install-ChocolateyShortcut -shortcutFilePath "$ENV:Public\Desktop\$shortcutName" -targetPath "$toolsDir\$exe" -WorkingDirectory "$toolsDir"
Install-ChocolateyShortcut -shortcutFilePath "$ENV:ProgramData\Microsoft\Windows\Start Menu\Programs\$shortcutName" -targetPath "$toolsDir\$exe" -WorkingDirectory "$toolsDir"
