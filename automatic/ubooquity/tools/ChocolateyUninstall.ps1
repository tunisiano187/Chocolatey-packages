$packageName = 'ubooquity'

remove-item "$env:Public\Desktop\Ubooquity.lnk" -Force -ErrorAction 'SilentlyContinue'
remove-item "$env:ProgramData\Microsoft\Windows\Start Menu\Programs\Ubooquity" -Force -ErrorAction 'SilentlyContinue'