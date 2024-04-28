$ErrorActionPreference = 'Stop';

$packageName      = $env:ChocolateyPackageName
$toolsDir         = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

$packageArgs = @{
  packageName     = $packageName
  fileType        = 'EXE'
  file            = Get-Item $toolsPath\*_.exe

  softwareName    = 'Pi Network*'

  validExitCodes= @(0, 3010, 1641)
  silentArgs   = '/S'
}

Install-ChocolateyInstallPackage @packageArgs
