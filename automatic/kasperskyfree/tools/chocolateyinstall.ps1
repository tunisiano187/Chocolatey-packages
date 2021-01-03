$ErrorActionPreference = 'Stop'; # stop on all errors
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

$url          = 'https://trial.s.kaspersky-labs.com/registered/w0wci3bxizuuge8wzc3j/3433333630357c44454c7c32_25100/ks4.021.2.16.590aben_25100.exe' # download url, HTTPS preferred
$checksum     = 'e64f9050cc08095b27a72f3ae224e6376714a840a4d6a62c6b0c1aaa78e247c2'
$checksumType = 'sha256'

$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  fileType      = 'EXE'
  url           = $url
  softwareName  = 'kasperskyfree*'

  checksum      = $checksum
  checksumType  = $checksumType

  silentArgs   = '/s'           # InstallShield

  validExitCodes= @(0,3010)
}

Install-ChocolateyPackage @packageArgs
