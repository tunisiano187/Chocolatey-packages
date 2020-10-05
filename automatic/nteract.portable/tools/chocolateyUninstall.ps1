$packageName= $env:ChocolateyPackageName

# Remove desktop shortcut
$desktop = $([System.Environment]::GetFolderPath([System.Environment+SpecialFolder]::DesktopDirectory))
$link = Join-Path $desktop "$packageName.lnk"
If (Test-Path $link) {
    Remove-Item "$link"
}
