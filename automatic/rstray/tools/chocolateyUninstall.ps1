$ErrorActionPreference = 'Stop'
Remove-Item "$(Get-ToolsLocation)\rstray" -Recurse -Force -ea 0

Uninstall-BinFile "rstray" "$(Get-ToolsLocation)\rstray\rstray.exe"
