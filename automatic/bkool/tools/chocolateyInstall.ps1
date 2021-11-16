$ErrorActionPreference = 'Stop'
$packageName    = $env:ChocolateyPackageName
$installerType  = 'exe'
$silentArgs     = '/quiet'
$url            = 'https://sdl.adaware.com/?bundleid=AR001&savename=Andy_47.260_1096_26_x86.exe'
$checksum       = '41dff12941f78bca3497d662294aeb9f55e99f15442e04165f0bdce94ffb73ef'
$checksumType   = 'sha256'
$validExitCodes = @(0,1603)

$packageArgs = @{
  packageName     = $packageName
  fileType        = $installerType
  url             = $url
  silentArgs      = $silentArgs
  validExitCodes  = $validExitCodes
  softwareName    = "$packageName*"
  checksum        = $checksum
  checksumType    = $checksumType
}

Install-ChocolateyPackage @packageArgs