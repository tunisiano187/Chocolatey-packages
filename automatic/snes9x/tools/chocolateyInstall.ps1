$ErrorActionPreference = 'Stop'
$packageName = $env:ChocolateyPackageName
$url = 'https://github.com/snes9xgit/snes9x/releases/download/1.61/snes9x-1.61-win32.zip'
$checksum = '95b4a40a76832338533ed3a084a5215764932265c18b101467f9819931d89c37'
$checksumType = 'sha256'
$url64 = 'https://github.com/snes9xgit/snes9x/releases/download/1.61/snes9x-1.61-win32-x64.zip'
$checksum64 = ''
$checksumType64 = ''
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