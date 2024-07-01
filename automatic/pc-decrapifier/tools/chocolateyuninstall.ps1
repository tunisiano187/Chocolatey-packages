$packageName= 'pc-decrapifier'

remove-item "$env:Public\Desktop\The PC Decrapifier.lnk" -Force -ErrorAction 'SilentlyContinue'
remove-item "$env:ProgramData\Microsoft\Windows\Start Menu\Programs\The PC Decrapifier.lnk" -Force -ErrorAction 'SilentlyContinue'