$packageName = 'crosextrafonts-carlito-font'
$toolsDir    = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

Install-ChocolateyFont "Carlito-Bold.ttf"
Install-ChocolateyFont "Carlito-BoldItalic.ttf"
Install-ChocolateyFont "Carlito-Italic.ttf"
Install-ChocolateyFont "Carlito-Regular.ttf"
Remove-Item "$toolsDir\*.ttf" | Out-Null
