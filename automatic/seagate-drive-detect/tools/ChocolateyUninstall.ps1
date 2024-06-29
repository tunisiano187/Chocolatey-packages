$packageName= 'seagate-drive-detect' 

remove-item "$env:Public\Desktop\Seagate Drive Detect.lnk" -Force -ErrorAction 'SilentlyContinue'
remove-item "$env:ProgramData\Microsoft\Windows\Start Menu\Programs\Seagate Drive Detect" -Force -ErrorAction 'SilentlyContinue'