$ErrorActionPreference = 'Stop';

$packageName      = $env:ChocolateyPackageName
$toolsDir         = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$file             = Get-ChildItem -Path $toolsDir -Filter "*.exe"

$packageArgs = @{
  packageName     = $packageName
  fileType        = 'EXE'
  file            = $file

  softwareName    = 'Pi Network*'

  validExitCodes= @(0, 3010, 1641)
  silentArgs   = '/S'
}

Install-ChocolateyInstallPackage @packageArgs
