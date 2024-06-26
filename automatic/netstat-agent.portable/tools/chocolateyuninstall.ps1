$ErrorActionPreference = 'Stop'

$packageName= 'netstat-agent.portable' 
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$ExeFile    = 'NetAgent.exe'
$ShortcutName = 'NetStat Agent'

remove-item "$env:Public\Desktop\$ShortcutName.lnk" -Force -ErrorAction 'SilentlyContinue'
remove-item "$env:ProgramData\Microsoft\Windows\Start Menu\Programs\$ShortcutName.lnk" -Force -ErrorAction 'SilentlyContinue'
