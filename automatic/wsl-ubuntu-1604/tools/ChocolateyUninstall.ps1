$ErrorActionPreference = 'Stop'
$packageName    = 'wsl-ubuntu-1604'

wslconfig /unregister Ubuntu
wslconfig /list

Uninstall-BinFile -Name Ubuntu1604