$ErrorActionPreference = 'Stop' # stop on all errors

$toolsDir     = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

$url          = '{{DownloadUrl}}' # download url, HTTPS preferred
$checksum     = ''
$url64        = '{{DownloadUrlx64}}' # 64bit URL here (HTTPS preferred) or remove - if installer contains both (very rare), use $url
$checksum64   = ''
$checksumType = ''

$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  unzipLocation = $toolsDir
  fileType      = 'EXE' #only one of these: exe, msi, msu
  url           = $url
  url64bit      = $url64

  softwareName  = 'fluent-reader*' #part or all of the Display Name as you see it in Programs and Features. It should be enough to be unique

  checksum      = $checksum32
  checksumType  = $checksumType #default is md5, can also be sha1, sha256 or sha512
  checksum64    = $checksum64
  checksumType64= $checksumType #default is checksumType

  validExitCodes= @(0, 3010, 1641)

  silentArgs   = '/S'           # NSIS
}

Install-ChocolateyPackage @packageArgs
