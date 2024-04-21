$ErrorActionPreference = 'Stop'

$toolsPath = Split-Path $MyInvocation.MyCommand.Definition
. $toolsPath\helpers.ps1

$pp = Get-PackageParameters

$packageName    = $env:ChocolateyPackageName
$url            = 'https://github.com/IntelRealSense/librealsense/releases/download/v2.55.1/Intel.RealSense.SDK-WIN10-2.55.1.6486.exe'
$checksum       = 'd8b472f234a08960431d788280643fbbfb0d2508d5a126dfa64c5e742507eaf6'
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
