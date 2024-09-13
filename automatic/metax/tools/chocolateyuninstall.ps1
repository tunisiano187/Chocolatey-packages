$ErrorActionPreference = 'Stop'
$packageName = 'metax'

Remove-Item "$ENV:ChocolateyInstall\bin\MetaX.bat" -Force -ErrorAction SilentlyContinue
