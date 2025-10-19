$ErrorActionPreference  = 'Stop';

$toolsDir               = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

$url64                  = 'https://www.crucial.com/content/dam/crucial/support/storage-executive-win-64.zip'
$checksum64             = ''
$checksumType64         = ''
$version				        = '11.05.052025.00'

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
