$ErrorActionPreference = 'Stop';
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$file32         = "$(Join-Path $toolsDir -ChildPath 'ofview.zip')"
$file64         = "$(Join-Path $toolsDir -ChildPath 'ofview-x64.zip')"

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  file           = $file32
  file64         = $file64
  unzipLocation  = $toolsDir
}

Install-ChocolateyUnzip @packageArgs
