$ErrorActionPreference = 'Stop' # stop on all errors

$url          = 'https://cachev2-ams03.cdn.yandex.net/download.cdn.yandex.net/browser/int/24_4_3_1011_58103/en/Yandex.exe'
$checksum     = 'c7efc179ab82cac40a5a04dc362f2423a41bd7ddb9acd37522eec5b3b6e16ba5'
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
