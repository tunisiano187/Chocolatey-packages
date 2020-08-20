$ErrorActionPreference = 'Stop'

$installLocation = Join-Path "$env:ChocolateyInstall\lib" "010editor.portable\tools"

Write-Host "Removing 010editor.portable from '$installLocation'"
Remove-Item $installLocation -Recurse -Force -ea 0