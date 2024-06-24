$ErrorActionPreference = 'Stop' # stop on all errors

$url          = 'https://cachev2-kiv03.cdn.yandex.net/download.cdn.yandex.net/browser/int/24_6_1_768_59922/en/Yandex.exe'
$checksum     = 'dda93ee194e0a5d74e9d175889b9894839648e5152e956b68cd210a93b72ab03'
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
