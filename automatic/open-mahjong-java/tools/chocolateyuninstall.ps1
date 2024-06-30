$packageName  = 'open-mahjong-java'
$ShortcutName = 'Open Mahjong.lnk'

remove-item "$env:Public\Desktop\$ShortcutName" -Force -ErrorAction 'SilentlyContinue'
remove-item "$env:ProgramData\Microsoft\Windows\Start Menu\Programs\$ShortcutName" -Force -ErrorAction 'SilentlyContinue'