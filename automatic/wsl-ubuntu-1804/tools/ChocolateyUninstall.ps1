$ErrorActionPreference = 'Stop'
$packageName    = 'wsl-ubuntu-1804'

wslconfig /unregister Ubuntu-18.04
wslconfig /list
