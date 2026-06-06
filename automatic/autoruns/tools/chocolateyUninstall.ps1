$ErrorActionPreference = 'Stop'
$programs     = "$env:ProgramData\Microsoft\Windows\Start Menu\Programs"
$shortcutPath = Join-Path $programs 'Autoruns.lnk'
if (Test-Path $shortcutPath) { Remove-Item $shortcutPath -Force }
