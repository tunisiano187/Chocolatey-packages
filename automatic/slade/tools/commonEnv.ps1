$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

$appName = 'Slade'
$installLocation = "$(Join-Path $toolsDir $appName)"
$startMenuDir = [IO.Path]::Combine($ENV:AppData, 'Microsoft\Windows\Start Menu\Programs', $appName)
$binLocation = "$(Join-Path $installLocation 'SLADE.exe')"
