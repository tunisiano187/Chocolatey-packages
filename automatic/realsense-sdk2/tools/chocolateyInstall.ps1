$ErrorActionPreference = 'Stop'

$toolsPath = Split-Path $MyInvocation.MyCommand.Definition
. $toolsPath\helpers.ps1

$pp = Get-PackageParameters

$packageName    = $env:ChocolateyPackageName
$url            = 'https://github.com/realsenseai/librealsense/releases/download/v2.58.3/RealSense.SDK-WIN10-2.58.3.10794.exe'
$checksum       = '5648d1fe1638d7b7fe2b4127de338275bc66a770753bfac3e29a41302fd7f6d3'
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
