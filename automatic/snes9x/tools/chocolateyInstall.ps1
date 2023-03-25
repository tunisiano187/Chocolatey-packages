$ErrorActionPreference = 'Stop'
$packageName = $env:ChocolateyPackageName
$url = 'https://github.com/snes9xgit/snes9x/releases/download/1.62/snes9x-1.62-win32.zip'
$checksum = 'b040842c9ede34ecb7839e2fe282a8db29923f15c45ee96cb80eabb5dd844e2e'
$checksumType = 'sha256'
$url64 = 'https://github.com/snes9xgit/snes9x/releases/download/1.62/snes9x-1.62-win32-x64.zip'
$checksum64 = '6ecc383f6d1e3849b10c26c62ce0b8ac702e00fd391b7207265057a8b7d2bba4'
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
