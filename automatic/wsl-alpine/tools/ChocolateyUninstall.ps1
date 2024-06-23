$ErrorActionPreference = 'Stop'
$packageName = 'wsl-alpine'
$shortcutName = 'Alpine.lnk'

wslconfig /unregister Alpine
wslconfig /list
Uninstall-BinFile Alpine
Remove-Item "$ENV:Public\Desktop\$shortcutName" -Force -ErrorAction SilentlyContinue
Remove-Item "$ENV:ProgramData\Microsoft\Windows\Start Menu\Programs\$shortcutName" -Force -ErrorAction SilentlyContinue
