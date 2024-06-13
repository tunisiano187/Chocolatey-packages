$ErrorActionPreference = 'Stop' # stop on all errors

$url          = 'https://cachev2-ams01.cdn.yandex.net/download.cdn.yandex.net/browser/int/24_6_0_1878_59457/en/Yandex.exe'
$checksum     = '9daed91424bdda07a9976544151182a41b0b2c7112792947f650c9b571792d74'
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
