$ErrorActionPreference = 'Stop';

$packageName  = $env:ChocolateyPackageName
$url          = 'https://github.com/nteract/nteract/releases/download/v0.25.1/nteract-Setup-0.25.1.exe'
$checksum     = 'd0e330d4e460b0f5633030307fa5cdf1a22cb9bf0de43a31db9f83286563853b'
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
  validExitCodes= @(0)
}

Install-ChocolateyPackage @packageArgs
