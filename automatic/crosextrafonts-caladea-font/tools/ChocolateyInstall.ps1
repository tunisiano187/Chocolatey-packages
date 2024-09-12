$packageName = 'crosextrafonts-caladea-font'
$toolsDir    = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

Install-ChocolateyFont "$toolsDir\Caladea-Bold.ttf"
Install-ChocolateyFont "$toolsDir\Caladea-BoldItalic.ttf"
Install-ChocolateyFont "$toolsDir\Caladea-Italic.ttf"
Install-ChocolateyFont "$toolsDir\Caladea-Regular.ttf"
Remove-Item "$toolsDir\*.ttf" | Out-Null
