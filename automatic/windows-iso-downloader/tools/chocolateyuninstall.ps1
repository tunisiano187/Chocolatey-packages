$ErrorActionPreference = 'Stop'
$packageName  = 'windows-iso-downloader'
$ShortcutName = 'Microsoft Windows and Office ISO Download Tool.lnk'

remove-item "$ENV:Public\Desktop\$ShortcutName" -Force -ErrorAction SilentlyContinue
remove-item "$ENV:ProgramData\Microsoft\Windows\Start Menu\Programs\$ShortcutName" -Force -ErrorAction SilentlyContinue
