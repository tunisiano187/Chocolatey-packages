$ErrorActionPreference  = 'Stop';

$toolsDir               = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

$url64                  = 'https://www.crucial.com/content/dam/crucial/support/storage-executive-win-64.zip'
$checksum64             = '297a00cb8dd434876ca58998bcbf50f0d79d5736f63f633eaf57a5496903b6b1'
$checksumType64         = 'sha256'
$version				        = '8.07'

$packageArgs = @{
  packageName           = $env:ChocolateyPackageName
  unzipLocation         = $toolsDir
  fileType              = 'EXE'
  softwareName          = "Crucial Storage Executive*"
  url64                 = $url64
  checksum64            = $checksum64
  checksumType64        = $checksumType64
  validExitCodes        = @(0)
  silentArgs			      = '--unattendedmodeui none --mode unattended'
}

Install-ChocolateyZipPackage @packageArgs
pushd $toolsDir
$fileName = Get-ChildItem -Filter "StorageExecutive-$version*"
$packageArgs.file = Join-Path -Path $toolsDir -ChildPath $fileName
Install-ChocolateyInstallPackage @packageArgs
del $fileName
popd
