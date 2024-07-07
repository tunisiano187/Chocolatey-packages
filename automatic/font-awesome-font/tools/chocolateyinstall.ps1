$ErrorActionPreference = 'Stop'
$packageName = 'font-awesome-font'
$toolsDir    = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$file         = "$toolsDir\fontawesome-free-$ENV:ChocolateyPackageVersion-desktop.zip"

$packageArgs = @{
  packageName   = $packageName
  unzipLocation = $toolsDir
  fileType      = 'ZIP'
  file          = $file
}

Get-ChocolateyUnzip @packageArgs

foreach ($otf in $((Get-ChildItem -Path $toolsDir -Filter "*.otf" -Recurse).FullName)) {
  Install-ChocolateyFont $otf
}

Remove-Item "$toolsDir\fontawesome-free-$ENV:ChocolateyPackageVersion-desktop" -Recurse -ErrorAction SilentlyContinue | Out-Null
Remove-Item "$toolsDir\*.zip" -ErrorAction SilentlyContinue | Out-Null
