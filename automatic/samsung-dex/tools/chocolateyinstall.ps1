$ErrorActionPreference = 'Stop'

$url          = 'https://downloadcenter.samsung.com/content/SW/202405/20240521131259562/SamsungDeXSetupWin.exe'
$checksum     = 'f7a07a73cd8e73ad6a8bf4a6abee6217d6c583b2e37657cab17bc53e4ad31dd3'
$checksumType = 'sha256'

$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  fileType      = 'EXE'
  url           = $url

  softwareName  = 'samsung-dex*'

  checksum      = $checksum
  checksumType  = $checksumType

  silentArgs    = "/S"
  validExitCodes= @(0, 3010, 1641)
}

Install-ChocolateyPackage @packageArgs
