$ErrorActionPreference = 'Stop'
$packageName  = 'beebeep'
$ShortcutName = 'beeBEEP'

Remove-Item "$ENV:Public\Desktop\$ShortcutName.lnk" -Force -ErrorAction SilentlyContinue
Remove-Item "$ENV:ProgramData\Microsoft\Windows\Start Menu\Programs\$ShortcutName.lnk" -Force -ErrorAction SilentlyContinue
