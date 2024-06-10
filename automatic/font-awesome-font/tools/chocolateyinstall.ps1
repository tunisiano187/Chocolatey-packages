$ErrorActionPreference = 'Stop'
$packageName = 'font-awesome-font'
$toolsDir    = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url         = "$toolsDir\fontawesome-free-$ENV:ChocolateyPackageVersion-desktop.zip"

$packageArgs = @{
  packageName   = $packageName
  unzipLocation = $toolsDir
  fileType      = 'ZIP'
  url           = $url
  }
  
Install-ChocolateyZIPPackage @packageArgs
 
Install-ChocolateyFont "$toolsDir\fontawesome-free-$ENV:ChocolateyPackageVersion-desktop\otfs\Font Awesome 5 Brands-Regular-400.otf"
Install-ChocolateyFont "$toolsDir\fontawesome-free-$ENV:ChocolateyPackageVersion-desktop\otfs\Font Awesome 5 Free-Regular-400.otf"
Install-ChocolateyFont "$toolsDir\fontawesome-free-$ENV:ChocolateyPackageVersion-desktop\otfs\Font Awesome 5 Free-Solid-900.otf"
 
Remove-Item "$toolsDir\fontawesome-free-$ENV:ChocolateyPackageVersion-desktop" -Recurse -ErrorAction SilentlyContinue | Out-Null
Remove-Item "$toolsDir\*.zip" -ErrorAction SilentlyContinue | Out-Null
