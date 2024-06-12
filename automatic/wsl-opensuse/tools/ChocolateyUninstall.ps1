$ErrorActionPreference = 'Stop'
$packageName    = 'wsl-opensuse'

wslconfig /unregister openSUSE-42
wslconfig /list
