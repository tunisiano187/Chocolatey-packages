$ErrorActionPreference = 'Stop'
$packageName  = 'tageditor' 
$shortcutName = 'Tag Editor.lnk'

Uninstall-BinFile tageditor
Remove-Item "$ENV:Public\Desktop\$shortcutName" -Force -ErrorAction SilentlyContinue
Remove-Item "$ENV:ProgramData\Microsoft\Windows\Start Menu\Programs\$shortcutName" -Force -ErrorAction SilentlyContinue
