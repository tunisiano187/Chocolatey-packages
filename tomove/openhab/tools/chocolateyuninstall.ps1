$packageName  = 'openhab'
$ShortcutName = 'openHAB'

remove-item "$env:Public\Desktop\$ShortcutName.lnk" -Force -ErrorAction 'SilentlyContinue'
remove-item "$env:ProgramData\Microsoft\Windows\Start Menu\Programs\$ShortcutName.lnk" -Force -ErrorAction 'SilentlyContinue'