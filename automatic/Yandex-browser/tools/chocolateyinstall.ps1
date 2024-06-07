$ErrorActionPreference = 'Stop' # stop on all errors

$url          = 'https://cachev2-kiv03.cdn.yandex.net/download.cdn.yandex.net/browser/int/24_4_5_499_59344/en/Yandex.exe'
$checksum     = '6604b14f7a5bc2997e3926d7f1e951e9e9041d9718c131bc06f8a9a4ebd96d4b'
$checksumType = 'sha256'

$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  fileType      = 'EXE'
  url           = $url

  softwareName  = 'Yandex-browser*' #part or all of the Display Name as you see it in Programs and Features. It should be enough to be unique

  checksum      = $checksum
  checksumType  = $checksumType

  silentArgs    = "--silent"
  validExitCodes= @(0,1,3) #please insert other valid exit codes here
}

Install-ChocolateyPackage @packageArgs
