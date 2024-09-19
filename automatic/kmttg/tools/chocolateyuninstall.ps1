$ErrorActionPreference = 'Stop'
$packageName = 'kmttg'

Remove-Item "$ENV:Public\Desktop\kmttg.lnk" -Force -ErrorAction SilentlyContinue
Remove-Item "$ENV:ProgramData\Microsoft\Windows\Start Menu\Programs\kmttg.lnk" -Force -ErrorAction SilentlyContinue
