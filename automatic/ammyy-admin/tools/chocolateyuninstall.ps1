$ErrorActionPreference = 'Stop'
$packageName= 'ammyy-admin' 

Start-CheckandStop "AA_v3"

Remove-Item "$env:Public\Desktop\Ammyy Admin.lnk" -Force -ErrorAction SilentlyContinue
Remove-Item "$env:ProgramData\Microsoft\Windows\Start Menu\Programs\Ammyy Admin.lnk" -Force -ErrorAction SilentlyContinue
