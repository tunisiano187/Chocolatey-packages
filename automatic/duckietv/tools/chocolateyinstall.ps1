$ErrorActionPreference = 'Stop'

$packageName = 'duckietv'
$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url = 'https://github.com/DuckieTV/Nightlies/releases/download/Nightly-202404110853/DuckieTV-202404110853-windows-x32.zip'
$url64 = 'https://github.com/DuckieTV/Nightlies/releases/download/Nightly-202404110853/DuckieTV-202404110853-windows-x64.zip'
$checksum = '47e000d439bab1cd10aee6d3de3856141fceef53e17694b5b16cec0ad2ee4ef0'
$checksum64 = 'f575cfd7848395f153514badf24114f44ac5e8c7fff45ce7bff8501adc09663c'
$checksumType = 'sha256'
$silentArgs = '/S'
$validExitCodes = @(0)
$bits = Get-ProcessorBits
$fileLocation = "$env:ChocolateyInstall\lib\$packageName\tools\DuckieTV-$env:ChocolateyPackageVersion-windows-x$bits.exe"

$packageArgs = @{
  packageName    = $packageName
  fileType       = 'ZIP'
  url            = $url
  url64Bit       = $url64
  unzipLocation  = $toolsDir
  checksum       = $checksum
  checksum64     = $checksum64
  checksumType   = $checksumType
  checksumType64 = $checksumType
}

Install-ChocolateyZipPackage @packageArgs

$packageArgs = @{
  packageName    = $packageName
  fileType       = 'EXE'
  file           = $fileLocation
  silentArgs     = $silentArgs
  validExitCodes = $validExitCodes
  softwareName   = 'DuckieTV*'
}

Install-ChocolateyInstallPackage @packageArgs
