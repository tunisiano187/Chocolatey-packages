$packageName   = 'sdio'
$shortcutName  = 'Snappy Driver Installer Origin'

Remove-Item "$env:Public\Desktop\$shortcutName.lnk" -Force -ErrorAction 'SilentlyContinue'
Remove-Item "$env:ProgramData\Microsoft\Windows\Start Menu\Programs\$shortcutName.lnk" -Force -ErrorAction 'SilentlyContinue'

if ((Test-Path -path "$ENV:ALLUSERSPROFILE\SDIO")) {
    Remove-Item "$ENV:ALLUSERSPROFILE\SDIO" -Force -Recurse
}
