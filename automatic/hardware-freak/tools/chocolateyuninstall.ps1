$packageName= 'hardware-freak' 

remove-item "$env:Public\Desktop\Hardware Freak.lnk" -Force -ErrorAction 'SilentlyContinue'
remove-item "$env:ProgramData\Microsoft\Windows\Start Menu\Programs\Hardware Freak.lnk" -Force -ErrorAction 'SilentlyContinue'