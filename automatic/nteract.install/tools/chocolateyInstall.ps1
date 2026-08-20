$ErrorActionPreference = 'Stop';

$packageName  = $env:ChocolateyPackageName
$url          = 'https://github.com/nteract/nteract/releases/download/v2.7.1-stable.202608192148/nteract-stable-windows-x64.exe'
$checksum     = 'a8dfc8cb118baa5ebbc00d794f337676c2aa648e1e8c0a89a7885efd87d6aba4'
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
  validExitCodes= @(0, 1, 2)
}

Install-ChocolateyPackage @packageArgs
