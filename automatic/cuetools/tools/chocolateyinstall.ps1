$ErrorActionPreference = 'Stop';
$toolsDir     = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  softwareName  = 'cuetools*'
  fileType      = 'zip'
  silentArgs    = "/S"
  validExitCodes= @(0) #please insert other valid exit codes here
  url           = "https://github.com/gchudov/cuetools.net/releases/download/v2.2.5/CUETools_2.2.5.zip"  #download URL, HTTPS preferrred
  checksum      = '4e311a444519869c4121f59b8bb11f475eb39f5ef0928b433e40230d1e25dda6'
  checksumType  = 'sha256'
  destination   = $toolsDir
}

Install-ChocolateyZipPackage @packageArgs

## See https://docs.chocolatey.org/en-us/create/functions/