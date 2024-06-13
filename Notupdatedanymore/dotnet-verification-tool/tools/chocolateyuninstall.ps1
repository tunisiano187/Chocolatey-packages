$packageName = 'dotnet-verification-tool'

remove-item "$env:Public\Desktop\dotNET Framework Setup Verification Tool.lnk" -Force -ErrorAction 'SilentlyContinue'
remove-item "$env:ProgramData\Microsoft\Windows\Start Menu\Programs\dotNET Framework Setup Verification Tool.lnk" -Force -ErrorAction 'SilentlyContinue'

