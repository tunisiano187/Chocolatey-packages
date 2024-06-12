$ErrorActionPreference = 'Stop'
$packageName = 'serva'

remove-item "$env:Public\Desktop\Serva.lnk" -Force -ErrorAction SilentlyContinue
remove-item "$env:ProgramData\Microsoft\Windows\Start Menu\Programs\Serva.lnk" -Force -ErrorAction SilentlyContinue

