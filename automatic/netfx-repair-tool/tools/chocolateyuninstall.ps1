$packageName= 'netfx-repair-tool'

remove-item "$env:Public\Desktop\Microsoft .NET Framework Repair Tool.lnk" -Force -ErrorAction 'SilentlyContinue'
remove-item "$env:ProgramData\Microsoft\Windows\Start Menu\Programs\Microsoft .NET Framework Repair Tool.lnk" -Force -ErrorAction 'SilentlyContinue'