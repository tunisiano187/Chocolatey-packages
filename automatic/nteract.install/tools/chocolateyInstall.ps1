$ErrorActionPreference = 'Stop';

$packageName  = $env:ChocolateyPackageName
$url          = 'https://github.com/nteract/nteract/releases/download/v2.6.2-stable.202606300322/nteract-stable-windows-x64.exe'
$checksum     = '62b4a24d65a21a8a5ec3077d9fa2a4bdd326c2a5ebd901b883bc436ca106d65d'
$checksumType = 'sha256'

$toolsDir     = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

$packageArgs = @{
  packageName   = $packageName
  unzipLocation = $toolsDir
  fileType      = 'EXE'
  url           = $url

  softwareName  = 'nteract*'

  checksum      = $checksum
  checksumType  = $checksumType

  silentArgs   = '/S' # NSIS
  validExitCodes= @(0, 2)
}

Install-ChocolateyPackage @packageArgs
