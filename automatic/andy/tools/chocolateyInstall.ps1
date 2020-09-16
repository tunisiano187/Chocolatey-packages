$ErrorActionPreference = 'Stop'
$packageName    = $env:ChocolateyPackageName
$installerType  = 'exe'
$silentArgs     = '/quiet'
$url            = 'https://sdl.adaware.com/?bundleid=AR001&savename=Andy_47.260_1096_26_x86.exe'
$checksum       = '41dff12941f78bca3497d662294aeb9f55e99f15442e04165f0bdce94ffb73ef'
$checksumType   = 'sha256'
$url64          = 'https://sdl.adaware.com/?bundleid=AR001&savename=Andy_47.260_1096_26_x64.exe'
$checksum64     = '41dff12941f78bca3497d662294aeb9f55e99f15442e04165f0bdce94ffb73ef'
$checksumType64 = 'sha256'
$validExitCodes = @(0)

$extractDir   = "$toolsDir\extracted"
$fileLocation = "$extractDir\Carrier.exe"

$packageArgs = @{
    packageName   = $packageName
    unzipLocation = $extractDir
    fileType      = 'ZIP'
    url           = $url
    checksum      = $checksum
    checksumType  = $checksumType
    url64bit      = $url64
    checksum64    = $checksum64
    checksumType64= $checksumType64
  }

  Install-ChocolateyZipPackage @packageArgs

  $packageArgs = @{
    packageName    = $packageName
    fileType       = $installerType
    file           = $fileLocation
    silentArgs     = $silentArgs
    validExitCodes = $validExitCodes
    softwareName   = 'uTorrent*'
  }

  Install-ChocolateyPackage @packageArgs

  Start-Sleep -s 10
  Remove-Item "$extractDir" -Recurse -ErrorAction SilentlyContinue | Out-Null
