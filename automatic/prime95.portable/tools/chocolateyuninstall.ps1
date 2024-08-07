$ErrorActionPreference = 'Stop'
$packageName= 'prime95.portable'
$ShortcutName = 'Prime95'

if((get-process "prime95" -ea SilentlyContinue) -eq $Null){
        Write-Host  "prime95 not running. (Good!)"
}
else{
    Write-Host  "Stopping Prime95..."
    Stop-Process -processname "prime95"
    Start-Sleep -s 3
 }

remove-item "$env:Public\Desktop\$ShortcutName.lnk" -Force -ErrorAction 'SilentlyContinue'
remove-item "$env:ProgramData\Microsoft\Windows\Start Menu\Programs\$ShortcutName.lnk" -Force -ErrorAction 'SilentlyContinue'
