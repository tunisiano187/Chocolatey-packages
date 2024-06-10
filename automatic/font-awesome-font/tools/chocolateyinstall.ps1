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

foreach ($otf in $((Get-ChildItem -Path $toolsDir -Filter "*.otf" -Recurse).FullName)) {
  Install-ChocolateyFont $otf
}

Remove-Item "$toolsDir\fontawesome-free-$ENV:ChocolateyPackageVersion-desktop" -Recurse -ErrorAction SilentlyContinue | Out-Null
Remove-Item "$toolsDir\*.zip" -ErrorAction SilentlyContinue | Out-Null
