$ErrorActionPreference = 'Stop'

$toolsPath = Split-Path $MyInvocation.MyCommand.Definition
. $toolsPath\helpers.ps1

$pp = Get-PackageParameters

$packageName    = $env:ChocolateyPackageName
$url            = 'https://github.com/realsenseai/librealsense/releases/download/v2.57.6/RealSense.SDK-WIN10-2.57.6.10172.exe'
$checksum       = 'a60b4142b9931579c8a1c06202e0b43bc303003e84cbd0927fd815585546f61e'
$checksumType   = 'sha256'

$packageArgs = @{
    PackageName  = $packageName
    FileType     = 'exe'
    SoftwareName = 'Intel® RealSense™ SDK 2.0'
    url          = $url
    checksum     = $checksum
    checksumType = $checksumType
    silentArgs   = "/VERYSILENT", "/SUPPRESSMSGBOXES", "/NORESTART", "/NOCANCEL", "/SP-",
                   "/LOG=`"$($env:TEMP)\$($env:chocolateyPackageName).$($env:chocolateyPackageVersion).Install.log`"",
                   (Get-InstallComponent $pp), (Get-InstallOption $pp)
    validExitCodes= @(0)
}

Install-ChocolateyPackage @packageArgs
