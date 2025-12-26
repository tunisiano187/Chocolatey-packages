$ErrorActionPreference  = 'Stop';

$toolsDir               = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

$url64                  = 'https://www.crucial.com/content/dam/crucial/support/storage-executive-win-64.zip'
$checksum64             = '672BB1ADEE81A02D4791149F97CADBAA59B12A74B0168425ABA7E455C4894355'
$checksumType64         = 'sha256'
$version				        = '11.11'

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
Push-Location $toolsDir
$fileName = Get-ChildItem -Filter "storage-executive-*"
$packageArgs.file = $fileName.FullName
Install-ChocolateyInstallPackage @packageArgs
Remove-Item $fileName
Pop-Location
