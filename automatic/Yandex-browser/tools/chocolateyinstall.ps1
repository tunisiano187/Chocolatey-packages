$ErrorActionPreference = 'Stop' # stop on all errors

$url          = 'https://cachev2-kiv03.cdn.yandex.net/download.cdn.yandex.net/browser/int/24_4_5_486_59156/en/Yandex.exe'
$checksum     = '6ebd898f37224607ab05376e195113fbd1cb441a201d58713b8ac51b0c1d4cab'
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
