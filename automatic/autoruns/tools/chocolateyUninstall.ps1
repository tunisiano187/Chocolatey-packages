$ErrorActionPreference = 'Stop'
$linkName = "Autoruns.lnk"
$programs = "$env:ProgramData\Microsoft\Windows\Start Menu\Programs\"
$shortcutFilePath = Join-Path $programs $linkName

if(Test-Path $shortcutFilePath) {
    Remove-Item $shortcutFilePath
}
