$ErrorActionPreference = 'Stop'
$packageName = 'ntfssecurity-psmodule'

Uninstall-Module -Name "NTFSSecurity" -Force
