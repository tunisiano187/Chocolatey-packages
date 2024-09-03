$packageName  = 'pytivo-wmcbrine'
$ShortcutName = 'PyTiVo (wmcbrine).lnk'

remove-item "$env:Public\Desktop\$ShortcutName" -Force -ErrorAction 'SilentlyContinue'
