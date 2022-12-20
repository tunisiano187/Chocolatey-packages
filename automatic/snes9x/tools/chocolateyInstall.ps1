$ErrorActionPreference = 'Stop'
$packageName = $env:ChocolateyPackageName
$url = 'http://www.s9x-w32.de/dl/snes9x-1.60-win32-x64.zip'
$checksum = 'd5914d166e6d9987429566b8ad70f42d8c851c87ababace738918966852a58a3'
$checksumType = 'sha256'
$url64 = 'http://www.s9x-w32.de/dl/snes9x-1.60-win32-x64.zip'
$checksum64 = 'd5914d166e6d9987429566b8ad70f42d8c851c87ababace738918966852a58a3'
$checksumType64 = 'sha256'
$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

$packageArgs = @{
    packageName   = $packageName
    unzipLocation = $toolsDir
    fileType      = 'ZIP'
    url           = $url
    checksum      = $checksum
    checksumType  = $checksumType
    Url64bit      = $url64
    checksum64    = $checksum64
    ChecksumType64= $checksumType64
}

Install-ChocolateyZipPackage @packageArgs