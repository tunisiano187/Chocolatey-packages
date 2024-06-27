$ErrorActionPreference = 'Stop'
$packageName    = 'unifying-fut'
$shortcutName   = 'Logitech Firmware Update Tool' 

Remove-Item "$ENV:PUBLIC\Desktop\$shortcutName.lnk" -Force -ErrorAction SilentlyContinue
Remove-Item "$ENV:ProgramData\Microsoft\Windows\Start Menu\Programs\$shortcutName.lnk" -Force -ErrorAction SilentlyContinue
