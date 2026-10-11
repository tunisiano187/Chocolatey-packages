$ErrorActionPreference = 'Stop'

$toolsPath = Split-Path $MyInvocation.MyCommand.Definition
. $toolsPath\helpers.ps1

$pp = Get-PackageParameters

$packageName    = $env:ChocolateyPackageName
$url            = 'https://github.com/realsenseai/librealsense/releases/download/v2.59.1/RealSense.SDK-WIN10-2.59.1.11053.exe'
$checksum       = '68502e782e3d906fb36b95acaceb3f4f158df9e22129a051286e4acabf777a33'
$checksumType   = 'sha256'

$packageArgs = @{
    PackageName  = $packageName
    FileType     = 'exe'
    SoftwareName = 'Intel(r) RealSense(TM) SDK 2.0'
    url          = $url
    checksum     = $checksum
    checksumType = $checksumType
    silentArgs   = "/VERYSILENT", "/SUPPRESSMSGBOXES", "/NORESTART", "/NOCANCEL", "/SP-",
                   "/LOG=`"$($env:TEMP)\$($env:chocolateyPackageName).$($env:chocolateyPackageVersion).Install.log`"",
                   (Get-InstallComponent $pp), (Get-InstallOption $pp)
    validExitCodes= @(0)
}

Install-ChocolateyPackage @packageArgs
