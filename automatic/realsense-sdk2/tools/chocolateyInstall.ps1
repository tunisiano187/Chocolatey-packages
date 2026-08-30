$ErrorActionPreference = 'Stop'

$toolsPath = Split-Path $MyInvocation.MyCommand.Definition
. $toolsPath\helpers.ps1

$pp = Get-PackageParameters

$packageName    = $env:ChocolateyPackageName
$url            = 'https://github.com/realsenseai/librealsense/releases/download/v2.58.4/RealSense.SDK-WIN10-2.58.4.10922.exe'
$checksum       = 'ed590d20e1186ccc26365bbf9fbb470a8d2ebf62fc5c2e905ef5779d308b0a18'
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
