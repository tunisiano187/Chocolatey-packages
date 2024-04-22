$ErrorActionPreference = 'Stop' # stop on all errors

$url          = ''
$checksum     = ''
$checksumType = ''

$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  fileType      = 'EXE'
  url           = $url

  softwareName  = 'Yandex-browser*' #part or all of the Display Name as you see it in Programs and Features. It should be enough to be unique

  checksum      = $checksum
  checksumType  = $checksumType

  silentArgs    = "--silent"
  #validExitCodes= @(0) #please insert other valid exit codes here
}

Install-ChocolateyPackage @packageArgs