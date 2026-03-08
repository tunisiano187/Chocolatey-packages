$ErrorActionPreference = 'Stop'
$packageName  = 'javauninstalltool' 
$shortcutName = 'Java Uninstall Tool.lnk'

remove-item "$env:Public\Desktop\$shortcutName" -Force -ErrorAction 'SilentlyContinue'
remove-item "$env:ProgramData\Microsoft\Windows\Start Menu\Programs\$shortcutName" -Force -ErrorAction 'SilentlyContinue'

