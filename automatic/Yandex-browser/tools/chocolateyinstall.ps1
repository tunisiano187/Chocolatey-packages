$ErrorActionPreference = 'Stop' # stop on all errors

$url          = 'https://cachev2-kiv03.cdn.yandex.net/download.cdn.yandex.net/browser/int/24_4_1_901_56713/en/Yandex.exe'
$checksum     = '45fc4234238e0f17c82efe97c277a92bf449ae0bf1236757124610f47bc46ab3'
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
