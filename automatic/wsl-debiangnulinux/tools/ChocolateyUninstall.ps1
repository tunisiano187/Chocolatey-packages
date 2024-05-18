$ErrorActionPreference = 'Stop'
$packageName    = 'wsl-debiangnulinux'

wslconfig /unregister Debian
wslconfig /list
