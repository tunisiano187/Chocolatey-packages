$packageName = 'killprocess'

remove-item "$env:Public\Desktop\KillProcess.lnk" -Force -ErrorAction 'SilentlyContinue'
remove-item "$env:ProgramData\Microsoft\Windows\Start Menu\Programs\KillProcess.lnk" -Force -ErrorAction 'SilentlyContinue'

