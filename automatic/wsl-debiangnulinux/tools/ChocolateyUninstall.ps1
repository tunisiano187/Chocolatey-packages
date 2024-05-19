$ErrorActionPreference = 'Stop'
$packageName    = 'wsl-debiangnulinux'
$shortcutName   = 'Debian.lnk'

wslconfig /unregister Debian
wslconfig /list

Remove-Item "$ENV:Public\Desktop\$shortcutName" -Force -ErrorAction SilentlyContinue
Remove-Item "$ENV:ProgramData\Microsoft\Windows\Start Menu\Programs\$shortcutName" -Force -ErrorAction SilentlyContinue